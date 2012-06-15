class FestivalTheme < ActiveRecord::Base
  attr_accessible :show_from, :high, :medium, :low, :shortcut, :splash
  has_attached_file :high, {:url => "/h/:hash.:extension", :default_url => "h/apple-touch-icon.png"}
  has_attached_file :medium, {:url => "/m/:hash.:extension", :default_url => "m/apple-touch-icon.png"}
  has_attached_file :low, {:url => "/l/:hash.:extension", :default_url => "l/apple-touch-icon-precomposed.png"}
  has_attached_file :shortcut, {:url => "/sh/:hash.:extension", :default_url => "l/apple-touch-icon.png"}
  has_attached_file :splash, {:url => "/sp/:hash.:extension", :default_url => "l/splash.png"}

  def self.current
    # Try to load from cache
    cached = Rails.cache.read('current_theme')
    if cached
      return cached
    end
    
    # Load from DB
    current = where("show_from <= ?", DateTime.now).order("show_from DESC").limit(1).first
    if current.nil?
      return FestivalTheme.new
    end
    
    # Cache the current value for 60 seconds
    Rails.cache.write('current_theme',current,{:ttl => 60.seconds})
    current
  end
  
  def active?
    self.id == FestivalTheme.current.id
  end
end
