class Book
  attr_reader :author, :title, :read
 
  def initialize(title, author)
    @title = title
    @author = author
    @read = false
  end
 
  def read!
    @read = true
  end
 
  def read?
    @read
  end
 
  def same_author?(author)
    @author == author
  end
 
  def same_title?(title)
    @title == title
  end
end