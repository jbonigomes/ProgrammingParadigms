
require "singleton"

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
    if @isOpen
      raise "The library is already open!"
    end

    @@calendar.advance

    @isOpen = true

    "Today is day #{@@calendar.date}"
  end

  def issue_card member
    unless @isOpen
      raise "The library is not open!"
    end

    if @@members.has_key?(member.name)
      raise "Member already exist"
    end

    @@members[member.name] = member

    "Library card issued to #{member.name}."
  end

  def serve member
    unless @isOpen
      raise "The library is not open!"
    end

    unless @@members.has_key?(member.name)
      raise "Member does not have a library card."
    end

    @serving = member

    "Now serving #{member.name}."
  end

  def check_out *books
    unless @isOpen
      raise "The library is not open!"
    end

    unless @serving
      raise "No member is currently being served."
    end

    books.each do |book|
      unless @@books.has_key?(book.id)
        raise "The library does not have book id #{book.id}"
      end

      book.check_out @@calendar.date + 7
      @serving.check_out @@books.delete book.id
    end

    "#{books.length} books have been checked out to #{@serving.name}."
  end

  def check_in *books
    unless @isOpen
      raise "The library is not open!"
    end

    unless @serving
      raise "No member is currently being served."
    end

    books.each do |book, some|
      unless @serving.books.has_key?(book.id)
        raise "The member does not have book id #{book.id}"
      end

      book.check_in
      @@books[book.id] = book
      @serving.give_back book
    end

    "#{@serving.name} has returned #{books.length} books."
  end

  def renew *books
    unless @isOpen
      raise "The library is not open!"
    end

    unless @serving
      raise "No member is currently being served."
    end

    books.each do |book|
      unless @serving.books.has_key?(book.id)
        raise "The member does not have book id #{book.id}"
      end

      book.check_out @@calendar.date + 7
    end

    "#{books.length} books have been renewed for #{@serving.name}."
  end

  def find_all_overdue_books
    unless @isOpen
      raise "The library is not open!"
    end

    overdue = "\n"

    @@members.each do |key, member|
      if member.books.empty?
        overdue += member.send_overdue_notice "No books are overdue"
      else
        overdue += member.send_overdue_notice "Books due:"

        member.books.each do |bookkey, book|
          overdue += "\n\t"
          overdue += book.to_s
        end
      end
    end

    overdue
  end

  def find_overdue_books
    unless @isOpen
      raise "The library is not open!"
    end

    if @serving.nil?
      raise "No member is currently being served."
    end

    overdue = "\n"

    if @serving.books.empty?
      overdue = @serving.send_overdue_notice "Member #{@serving.name} has no books overdue"
    else
      overdue = @serving.send_overdue_notice "Books due:"

      @serving.books.each do |key, book|
        overdue += "\t"
        overdue += book.to_s
      end
    end

    overdue
  end

  def close
    raise "The library is not open!" unless @isOpen

    @isOpen = false

    'Good night'
  end

  def quit
    'The library is now closed for renovations'
  end

end
