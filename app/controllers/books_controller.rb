class BooksController < ApplicationController
  before_filter :set_theme
  layout :set_layout
  
  def show
    
  end
protected

  def set_theme
    @theme = "books"
  end
end
