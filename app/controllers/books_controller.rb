class BooksController < ApplicationController
  before_filter :set_theme, :set_section
  layout :set_layout
  
  def show
    @book = Book.find_by_isbn(params[:id])
    @title = @book.title
    @amazon_book = @book.amazon_lookup
    @kindle_book = (@amazon_book && @amazon_book.kindle_asin) ? @book.kindle_lookup(@amazon_book.kindle_asin) : nil
    @itunes_link = @book.itunes_lookup
  end
  
protected

  def set_theme
    @theme = "books"
  end
  
  def set_section
    @section = "Books"
  end
end
