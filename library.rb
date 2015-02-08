require 'ap'
class Library

  def initialize
    @all_books = []
  end

  def create_book(title, author)
    book = {:title => title, :author=> author, :read=> false}
  end

  def add_to_library(book)
    @all_books.push(book)
  end

  def is_duplicate(book)
    @all_books.each do |library|
      if library[:title]==book[:title]
        return true
      end
    end
  end

  def find_book_by_title(title)
    my_book = @all_books.select{|book| book[:title]==title}
    if my_book.length == 1
      return my_book[0]
    else
      return false
    end
  end

  def read(book)
    if book[:read] == false
      book[:read] = true
      return book
    else
      return false
    end
  end

  def all_books
    @all_books
  end

  def all_unread
    @all_books.select{|book| book[:read]==false}
  end

  def all_unread_by_author(author)
    books = @all_books.select{|book| book[:read]==false && book[:author]==author}
  end

  def all_by_author(author)
    @all_books.select{|book| book[:author]==author}
  end
end



