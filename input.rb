require './library.rb'

class UserInterface
  def initialize
    @library = Library.new
  end

  def welcome
    puts "Welcome to your library!"
    control_panel
  end

  def control_panel
    input = gets.chomp
    begin
      if input.match(/^add/)
        add_book(input)
        control_panel
      elsif input.match(/\b^show all by\b/)
        show_all_by_author(input)
        control_panel
      elsif input.match(/\b^show all\b/)
        show_all
        control_panel
      elsif input.match(/\b^show unread by\b/)
        show_unread_by_author(input)
        control_panel   
      elsif input.match(/\b^show unread\b/)
        show_unread
        control_panel
      elsif input.match(/\b^read\b/)
        read(input)
        control_panel
      elsif input =="quit"
        puts "Bye!"
      else
        puts "I didn't get that, please try again!"
        control_panel
      end  
    rescue
      puts "Sorry, I didn't get that"
      control_panel
    end
  end

  def add_book(input)
    book = input.scan(/"([^"]*)"/)
    lib_book = @library.create_book(book[0][0], book[1][0])
    if @library.is_duplicate(lib_book) == true
      puts "That is already in your library"
    else
      @library.add_to_library(lib_book)
      puts "Added \"#{book[0][0]}\" by #{book[1][0]}"      
    end
  end

  def format_book(book)
    if book[:read] == true
      puts "\"#{book[:title]}\" by #{book[:author]} (read)"
    else
      puts "\"#{book[:title]}\" by #{book[:author]} (unread)"
    end
  end

  def show_all
    @library.all_books.each do |book|
      format_book(book)
    end
  end

  def show_all_by_author(input)
    author = input.match(/"(.*?)"/)[1]
    @library.all_by_author(author).each do |book|
      format_book(book)
    end
  end

  def show_unread
    @library.all_unread.each do |book|
      format_book(book)
    end
  end

  def show_unread_by_author(input)
    author = input.match(/"(.*?)"/)[1]
    if @library.all_unread_by_author(author).length < 1
      puts "No unread books by that author"
    else
      books = @library.all_unread_by_author(author)
      books.each do |book| 
        format_book(book)
      end
    end
  end

  def read(input)
    title = input.match(/"(.*?)"/)[1]
    book = @library.find_book_by_title(title)
    if book  == false
      puts "Sorry, I couldn't find that book"
    elsif @library.read(book) == false
      puts "You've already read #{title}"
    else
      @library.read(book)
      puts "You've read #{title}"
    end
  end
end

a = UserInterface.new
a.welcome
