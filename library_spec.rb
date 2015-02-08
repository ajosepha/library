require 'rspec'
require_relative 'library.rb'
# require_relative 'input.rb'

RSpec.configure do |config|
  # Use color in STDOUT
  config.color = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate
end

describe 'Library' do
  before :each do 
    @library = Library.new
    @book = {:title=> "The Grapes of Wrath", :author=> "John Steinbeck", :read=> false}
    @book_one = {:title=> "Of Mice and Men", :author=> "John Steinbeck", :read=> false}
    @book_two = {:title=> "A Discovery of Witches", :author=> "Deborah Harkness", :read=> true}
    @book_three = {:title=> "The Pearl", :author=> "John Steinbeck", :read=> true}
  end

  it "should create with a given author, title, and be unread by default"  do
    expect(@library.create_book("The Grapes of Wrath", "John Steinbeck")).to eq({:title=> "The Grapes of Wrath", :author=> "John Steinbeck", :read=> false})
  end

  it "should add a book to the library"  do
    expect(@library.add_to_library(@book)).to eq([@book])
  end

  it "should not allow the user to add 2 books with the same title" do
    dup_book = {:title=> "The Grapes of Wrath", :author=> "not John Steinbeck", :read=> false}
    @library.add_to_library(@book)
    expect(@library.is_duplicate(dup_book)).to be true
  end

  it "should find a book by its title" do
    @library.add_to_library(@book)
    expect(@library.find_book_by_title('The Grapes of Wrath')).to eq(@book)
  end

  it "should return false if the book cannot be found" do
    @library.add_to_library(@book)
    expect(@library.find_book_by_title('Murder She Wrote')).to be false
  end

  it "should return false if you have already read the book" do
    @library.add_to_library(@book_three)
    book = @library.find_book_by_title('The Pearl')
    expect(@library.read(book)).to be false
  end

  it "should read a book if you haven't read it before" do
    @library.add_to_library(@book)
    book = @library.find_book_by_title("The Grapes of Wrath")
    expect(@library.read(book)).to eq({:title=> "The Grapes of Wrath", :author=> "John Steinbeck", :read=> true})
  end

  it "should show you all the books in the library" do
    @library.add_to_library(@book)
    @library.add_to_library(@book_one)
    @library.add_to_library(@book_two)
    expect(@library.all_books).to eq([{:title=> "The Grapes of Wrath", :author=> "John Steinbeck", :read=> false}, {:title=> "Of Mice and Men", :author=> "John Steinbeck", :read=> false}, {:title=> "A Discovery of Witches", :author=> "Deborah Harkness", :read=> true}])
  end

  it "should show you all unread books in the library" do
    @library.add_to_library(@book)
    @library.add_to_library(@book_one)
    @library.add_to_library(@book_two)
    expect(@library.all_unread).to eq([{:title=> "The Grapes of Wrath", :author=> "John Steinbeck", :read=> false}, {:title=> "Of Mice and Men", :author=> "John Steinbeck", :read=> false}])
  end

  it "should show you all unread books in the library by an author" do
    @library.add_to_library(@book)
    @library.add_to_library(@book_one)
    @library.add_to_library(@book_two)
    expect(@library.all_unread_by_author("John Steinbeck")).to eq([ {:title=> "The Grapes of Wrath", :author=> "John Steinbeck", :read=> false}, {:title=> "Of Mice and Men", :author=> "John Steinbeck", :read=> false}])
  end

  it "should show you all books in the library by an author" do
    @library.add_to_library(@book)
    @library.add_to_library(@book_one)
    @library.add_to_library(@book_two)
    @library.add_to_library(@book_three)
    expect(@library.all_by_author("John Steinbeck")).to eq([{:title=> "The Grapes of Wrath", :author=> "John Steinbeck", :read=> false}, {:title=> "Of Mice and Men", :author=> "John Steinbeck", :read=> false}, {:title=> "The Pearl", :author=> "John Steinbeck", :read=> true}])
  end
end



