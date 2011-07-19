# encoding: utf-8
class ArticlesController < ApplicationController
  before_filter :set_theme, :set_section
  layout :set_layout
  
  def index
    @author = Author.find params[:author_id]
    @title = "#{@author.full_name} – Guardian articles"
    @articles = Article.search @author.full_name
  end
  
  def show
    @author = Author.find params[:author_id]
    @article = Article.find params[:id]
    @fields = @article['fields']
    @title = @fields['headline']
  end
  
protected

  def set_theme
    @theme = "authors"
  end

  def set_section
    @section = "Authors"
  end

end
