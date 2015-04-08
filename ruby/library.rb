
require 'singleton'

class Calendar

  attr_reader :date

  include Singleton

  def initialize
    @date = 0
  end

  def advance
    @date += 1
  end

end


class Book
  
  attr_reader :id, :title, :author, :due_date

  def initialize id, title, author
    @id       = id
    @title    = title
    @author   = author
    @due_date = nil
  end

  def check_out due_date
    @due_date = due_date
  end

  def check_in
    @due_date = nil
  end

  def to_s
    "#{@id}: #{@title}, by #{@author}"
  end

end


class Member

  attr_reader :name, :books

  def initialize name, library
    @name    = name
    @library = library
    @books   = Hash.new
  end

  def check_out book
    @books[book.id] = book
  end

  def give_back book
    @books.delete book.id
  end

  def send_overdue_notice notice
    "#{@name}: #{notice}"
  end

end


class Library

  # attr_reader :calendar

  include Singleton

  @@books    = nil
  @@calendar = nil

  def self.books= books
    @@books = books
  end

  def self.calendar= calendar
    @@calendar = calendar
  end

  def self.members= members
    @@members = members
  end

  def initialize
    @isOpen  = false
    @serving = nil
  end

  def open
    raise StandardError, 'The library is already open!' if @isOpen

    @@calendar.advance

    @isOpen = true

    "Today is day #{@@calendar.date}"
  end

  def issue_card member
    raise StandardError, 'The library is not open!' unless @isOpen
    raise StandardError, 'Member already exist' if @@members.has_key?(member.name)

    @@members[member.name] = member

    "Library card issued to #{member.name}."
  end

  def serve member
    raise StandardError, 'The library is not open!' unless @isOpen
    raise StandardError, 'Member does not have a library card.' unless @@members.has_key?(member.name)
    
    @serving = member.name

    "Now serving #{member.name}."
  end

  def find_all_overdue_books
    raise StandardError, 'The library is not open!' unless @isOpen

    @@members.each do |key, member|
      puts key
      puts member

      # "#{@name}: #{notice}"
    end

    # Prints a nicely formatted, multiline string, listing the names of
    # members who have overdue books, and for each such member, the
    # books that are overdue. Or, the string "No books are
    # overdue.”.
  end

  def find_overdue_books
    raise StandardError, 'The library is not open!' unless @isOpen
    raise StandardError, 'No member is currently being served.' if @serving.nil?

    # Prints a multiline string, each line containing one book (as returned
    # by the book's to_s method), of the books that have been checked out by the
    # member currently being served, and which are overdue. If the member has no
    # overdue books, the string “None” is printed.
  end

  def check_in *book_ids # * = 1..n of book numbers
    raise StandardError, 'The library is not open!' unless @isOpen
    raise StandardError, 'No member is currently being served.' unless @serving
    # raise StandardError, 'The library does not have book id' unless @serving.books_ids

    # The book is being returned by the current member (there must be one!), so 
    # return it to the collection and remove it from the set of books currently
    # checked out to the member.

    # The book_numbers are taken from the list printed by the search command.

    # Checking in a Book will involve both telling the Book that it is checked
    # in and returning the Book to this library's collection of available Books.

    # If successful, returns "name_of_member has returned n books.”.
  end

  def check_out *book_ids # 1..n book_ids
    raise StandardError, 'The library is not open!' unless @isOpen
    raise StandardError, 'No member is currently being served.' unless @serving
    # raise StandardError, 'The library does not have book id' unless book_ids

    # Checks out the book to the member currently being served (there
    # must be one!), or tells why the operation is not permitted.

    # The book_ids could have been found by a recent call to the search method.

    # Checking out a book will involve both telling the book that
    # it is checked out and removing the book from this library's collection
    # of available books.

    # If successful, returns "n books have been checked out to name_of_member.".
  end

  def renew *book_ids # 1..n book_ids
    raise StandardError, 'The library is not open!' unless @isOpen
    raise StandardError, 'No member is currently being served.' unless @serving
    # raise StandardError, 'The library does not have book id' unless book_ids

    # Renews the books for the member currently being served (by setting their
    # due dates to today's date plus 7) or tells why the operation is not
    # permitted.

    # If successful, returns "n books have been renewed for name_of_member.".
  end

  def close
    raise StandardError, 'The library is not open!' unless @isOpen

    @isOpen = false

    'Good night'
  end

  def quit
    'The library is now closed for renovations'
  end

end
