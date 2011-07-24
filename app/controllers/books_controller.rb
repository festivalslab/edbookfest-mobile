class BooksController < ApplicationController
  before_filter :set_theme, :set_section
  layout :set_layout
  
  def show
    @book = Book.find_by_eibf_id(params[:id])
    @title = @book.title
    @amazon_book = @book.amazon_lookup
  end
  
protected

  def set_theme
    @theme = "books"
  end
  
  def set_section
    @section = "Books"
  end
end
