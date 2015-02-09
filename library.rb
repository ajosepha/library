require 'ap'
require './book.rb'


class Library
 
  def initialize
    @all_books = []
  end
 
  def create_book(title, author)
    Book.new(title, author)
  end
 
  def add_to_library(new_book)
    raise "\"#{new_book.title}\" is already in your library!" if is_duplicate(new_book.title)
    @all_books.push(new_book)
  end
  
  def is_duplicate(title)
    book = @all_books.find{|book| book.title == title}
    book ? true : false
  end

  def find_by_title(title)
    book = @all_books.find{|book| book.title == title}
    raise "Can't find \"#{title}\"" if !book
    book
  end
 
  def read_book(title)
    book = find_by_title(title)
    raise "You have already read \"#{title}\"" if book.read
    book.read!
  end
 
  def all_books
    @all_books
    raise "You have no books" if @all_books.empty?
    @all_books
  end
 
  def all_unread
    books = @all_books.select{|book| !book.read?}
    raise "No unread books" if books.empty?
    books
  end
 
  def all_unread_by_author(author)
    books = @all_books.select{|book| !book.read? && book.same_author?(author)}
    raise "You have no unread books by #{author}" if books.empty?
    books
  end
 
  def all_by_author(author)
    books = @all_books.select{|book| book.same_author?(author)}
    raise "You have no books by #{author}" if books.empty?
    books
  end
end
 

 



