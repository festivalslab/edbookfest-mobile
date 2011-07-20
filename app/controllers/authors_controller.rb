class AuthorsController < ApplicationController
  before_filter :set_theme, :set_section
  layout :set_layout
  
  def show
    @author = Author.find(params[:id])
    @title = @author.full_name
  end

protected

  def set_theme
    @theme = "authors"
  end

  def set_section
    @section = "Authors"
  end

end
