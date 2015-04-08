
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

  def initialize name
    @name  = name
    @books = Hash.new
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

  include Singleton

  def self.books= books
    @@books = books
  end

  def self.members= members
    @@members = members
  end

  def self.calendar= calendar
    @@calendar = calendar
  end

  def initialize
    @isOpen   = false
    @serving  = nil
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
    
    @serving = member

    "Now serving #{member.name}."
  end

  def check_out *books
    raise StandardError, 'The library is not open!' unless @isOpen
    raise StandardError, 'No member is currently being served.' unless @serving

    books.each do |book|
      raise StandardError, "The library does not have book id #{book.id}" unless @@books.has_key?(book.id)

      book.check_out @@calendar.date + 7
      @serving.check_out @@books.delete book.id
    end

    "#{books.length} books have been checked out to #{@serving.name}."
  end

  def check_in *books
    raise StandardError, 'The library is not open!' unless @isOpen
    raise StandardError, 'No member is currently being served.' unless @serving

    books.each do |book, some|
      raise StandardError, "The member does not have book id #{book.id}" unless @serving.books.has_key?(book.id)
      book.check_in
      @@books[book.id] = book
      @serving.give_back book
    end

    "#{@serving.name} has returned #{books.length} books."
  end

  def renew *books
    raise StandardError, 'The library is not open!' unless @isOpen
    raise StandardError, 'No member is currently being served.' unless @serving

    books.each do |book|
      raise StandardError, "The member does not have book id #{book.id}" unless @serving.books.has_key?(book.id)
      book.check_out @@calendar.date + 7
    end

    "#{books.length} books have been renewed for #{@serving.name}."
  end

  def find_all_overdue_books
    raise StandardError, 'The library is not open!' unless @isOpen

    overdue = "\n"

    @@members.each do |key, member|
      if member.books.empty?
        overdue += member.send_overdue_notice 'No books are overdue'
      else
        overdue += member.send_overdue_notice 'Books due:'

        member.books.each do |bookkey, book|
          overdue += "\n\t"
          overdue += book.to_s
        end
      end
    end

    overdue
  end

  def find_overdue_books
    raise StandardError, 'The library is not open!' unless @isOpen
    raise StandardError, 'No member is currently being served.' if @serving.nil?

    overdue = "\n"

    if @serving.books.empty?
      overdue = @serving.send_overdue_notice "Member #{@serving.name} has no books overdue"
    else
      overdue = @serving.send_overdue_notice 'Books due:'

      @serving.books.each do |key, book|
        overdue += "\n\t"
        overdue += book.to_s
      end
    end

    overdue
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
