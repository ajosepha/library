require 'rspec'
require_relative 'library.rb'

RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end

describe 'Book' do

  before :each do
    @book = Book.new("Grapes of Wrath", "John Steinbeck")
  end

  it "creates a new book with a title" do
    expect(@book.title).to eq("Grapes of Wrath")
  end

  it "creates a new book with an author" do
    expect(@book.author).to eq("John Steinbeck")
  end

  it "creates an unread book" do
    expect(@book.read).to be false
  end

  it "reads a book" do
    expect(@book.read!).to be true
  end

  it "tells if a book is read" do
    expect(@book.read?).to be false
  end

  it "tells if a book has the same author" do
    expect(@book.same_author?("John Steinbeck")).to be true
  end

  it "tells if a book doesn't have the same author" do
    expect(@book.same_author?("F. Scott Fitzgerald")).to be false
  end

  it "tells if the book has the same title" do
    expect(@book.same_title?("Grapes of Wrath")).to be true
  end

  it "tells if the book doesn't the same title" do
    expect(@book.same_title?("Cannery Row")).to be false
  end
end


describe 'Library' do
  before :each do 
    @library = Library.new
    @book = Book.new("The Grapes of Wrath", "John Steinbeck")
    @book_one = Book.new("Of Mice and Men", "John Steinbeck")
    @book_two = Book.new("The Sun Also Rises", "Ernest Hemingway") 
  end

  it "creates a book with a given title" do
    book = @library.create_book("The Grapes of Wrath", "John Steinbeck")
    expect(book.title).to eq("The Grapes of Wrath")
  end

  it "creates a book with a given author" do
    book = @library.create_book("The Grapes of Wrath", "John Steinbeck")
    expect(book.author).to eq("John Steinbeck")
  end

  it "creates an unread book" do
    book = @library.create_book("The Grapes of Wrath", "John Steinbeck")
    expect(book.read?).to be false
  end

  it "adds a book to the library"  do
    expect(@library.add_to_library(@book)).to eq([@book])
  end

  it "returns true of a title already exists" do
    book = @library.create_book("The Grapes of Wrath", "John Steinbeck")
    @library.add_to_library(book)
    expect(@library.is_duplicate("The Grapes of Wrath")).to be true
  end

  it "does not add a book to the library if that title already exists" do
    book = @library.create_book("The Grapes of Wrath", "John Steinbeck")
    @library.add_to_library(book)
    duplicate_book = @library.create_book("The Grapes of Wrath", "John Steinbeck")
    expect {@library.add_to_library(duplicate_book)}.to raise_error("\"The Grapes of Wrath\" is already in your library!")
  end

  it "finds a book by its title" do
    @library.add_to_library(@book)
    expect(@library.find_by_title('The Grapes of Wrath')).to eq(@book)
  end

  it "returns an error if the book cannot be found" do
    @library.add_to_library(@book)
    expect {@library.find_by_title('Murder She Wrote')}.to raise_error("Can't find \"Murder She Wrote\"")
  end

  it "reads a book" do
    @library.add_to_library(@book)
    expect(@library.read_book("The Grapes of Wrath")).to be true
  end

  it "raises an error if you try to add the same book twice" do
    @library.add_to_library(@book)
    @library.read_book("The Grapes of Wrath")
    expect {@library.read_book("The Grapes of Wrath")}.to raise_error("You have already read \"The Grapes of Wrath\"")
  end

  it "shows you all the books in the library" do
    @library.add_to_library(@book)
    @library.add_to_library(@book_one)
    @library.add_to_library(@book_two)
    expect(@library.all_books).to eq([@book, @book_one, @book_two])
  end

  it "raises an error if you have no books in your library" do
    expect {@library.all_books}.to raise_error("You have no books")
  end

  it "shows you all unread books in the library" do
    @library.add_to_library(@book)
    @library.add_to_library(@book_one)
    @library.read_book("Of Mice and Men")
    expect(@library.all_unread).to eq([@book])
  end

  it "raises an error if you have no unread books in your library" do
    expect {@library.all_unread}.to raise_error("No unread books")
  end

  it "shows you all unread books in the library by an author" do
    @library.add_to_library(@book)
    @library.add_to_library(@book_one)
    @library.add_to_library(@book_two)
    @library.read_book("Of Mice and Men")
    expect(@library.all_unread_by_author("John Steinbeck")).to eq([@book])
  end

  it "raises an error if you have no unread books by an author" do
    @library.add_to_library(@book)
    @library.read_book(@book.title)
    expect {@library.all_unread_by_author("John Steinbeck")}.to raise_error("You have no unread books by John Steinbeck")
  end

  it "shows you all books in the library by an author" do
    @library.add_to_library(@book)
    @library.read_book(@book.title)
    @library.add_to_library(@book_one)
    @library.add_to_library(@book_two)
    expect(@library.all_by_author("John Steinbeck")).to eq([@book, @book_one])
  end

  it "raises an error if you have no books by an author" do
    @library.add_to_library(@book)
    expect {@library.all_by_author("Mark Twain")}.to raise_error("You have no books by Mark Twain")
  end
end



