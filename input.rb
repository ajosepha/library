require './library.rb'

require './library.rb'
 
class UserInterface
  def initialize
    @library = Library.new
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
      elsif input == "help"
        help
        control_panel
      elsif input =="quit"
        puts "Bye!"
      else
        puts "I didn't get that, please try again.  Type help if you would like assistance!"
        control_panel
      end
    rescue
      puts "Sorry, I didn't get that. Type help if you would like assistance!"
      control_panel
    end
  end

  def help
    puts "Here are the commands you can use"
    puts "-add \"title\" \"author\""
    puts "-read \"title\""
    puts "-show all"
    puts "-show all by \"author\""
    puts "-show unread by \"author\""
    puts "-show unread"
    puts "-quit"
  end
 
  def add_book(input)
    book = input.scan(/"([^"]*)"/)
    new_book = Book.new(book[0][0], book[1][0])
    begin
      @library.add_to_library(new_book)
      puts "Added \"#{new_book.title}\" by #{new_book.author}"
    rescue => ex
      puts ex
    end
  end
 
  def format_book(book)
    read_status = book.read? ? "(read)" : "(unread)"
    puts "\"#{book.title}\" by #{book.author} #{read_status}"
  end
 
  def show_all
    begin
      @library.all_books.each do |book|
        format_book(book)
      end
    rescue => ex
      puts ex
    end
  end
 
  def show_all_by_author(input)
    author = input.match(/"(.*?)"/)[1]
    begin
      @library.all_by_author(author).each do |book|
        format_book(book)
      end
    rescue => ex
      puts ex
    end
  end
 
  def show_unread
    begin
      @library.all_unread.each do |book|
        format_book(book)
      end
    rescue => ex
      puts ex
    end
  end
 
  def show_unread_by_author(input)
    author = input.match(/"(.*?)"/)[1]
    begin
      books = @library.all_unread_by_author(author)
      books.each do |book|
        format_book(book)
      end
    rescue => ex
      puts ex
    end
  end
 
  def read(input)
    title = input.match(/"(.*?)"/)[1]
    begin
      book = @library.find_by_title(title)
      book.read!
      puts "You've read \"#{title}\"!"
    rescue => ex
      puts ex
    end
  end
end

a = UserInterface.new
