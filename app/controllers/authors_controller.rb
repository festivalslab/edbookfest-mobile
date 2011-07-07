class AuthorsController < ApplicationController
  before_filter :set_theme
  layout :set_layout

  def index
    @title = "Authors"
    @section = "Authors"
  end

protected

  def set_theme
    @theme = "authors"
  end
end
