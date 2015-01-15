
class LibraryNotOpen < StandardError; end

class Calendar

  attr_reader :date

  # Gotta make this fudger singleton
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

  # Gotta make this fudger singleton
  def initialize

    book_id = 0
    @books  = Hash.new

    File.open('collection.txt').each do |line|
      
      book_id += 1
      title, author = line.split(/, /)
      @books[book_id] = Book.new book_id, title, author

    end

    @calendar = Calendar.new

    # Define an empty dictionary of members. The keys will be the names
    # of members and the values will be the corresponding Member objects.
    @members = Hash.new

    @isOpen = false

    # Sets the current member (the one being served) to nil
  end

  def open
    raise LibraryNotOpen if @isOpen

    @calendar.advance

    @isOpen = true

    # Return the string "Today is day n.”
    "Today is day #{@calendar.date}"
  end

  def find_all_overdue_books
    # Prints a nicely formatted, multiline string, listing the names of
    # members who have overdue books, and for each such member, the
    # books that are overdue. Or, the string "No books are
    # overdue.”.
  end

  def issue_card name_of_member
    # Issues a library card to the person with this name. However, no
    # member should be permitted to have more than one library card.
    # Returns either "Library card issued to name_of_member." or
    # "name_of_member already has a library card.”.
    # Possible Exception: "The library is not open.".
  end

  def serve name_of_member
    # Specifies which member is about to be served (and quits serving the
    # previous member, if any). The purpose of this method is so that you
    # don't have to type in the person's name again and again for every
    # book that is to be checked in or checked out. What the method should
    # actually do is to look up the member's name in the dictionary, and
    # save the returned Member object in a data variable of this library.
    # Returns either "Now serving name_of_member." or
    # "name_of_member does not have a library card.".
    # Possible Exception: "The library is not open."
  end

  def find_overdue_books
    # Prints a multiline string, each line containing one book (as returned
    # by the book's to_s method), of the books that have been checked out
    # by the member currently being served, and which are overdue. If the
    # member has no overdue books, the string “None” is printed.

    # May throw an Exception with an appropriate message:
    #  • "The library is not open.”
    #  • "No member is currently being served.”
  end

  def check_in *book_numbers # * = 1..n of book numbers
    # The book is being returned by the current member (there must be
    # one!), so return it to the collection and remove it from the set of
    # books currently checked out to the member. The book_numbers are
    # taken from the list printed by the search command. Checking in a
    # Book will involve both telling the Book that it is checked in and
    # returning the Book to this library's collection of available Books.
    # If successful, returns "name_of_member has returned n
    # books.”.
    # May throw an Exception with an appropriate message:
    #  • "The library is not open."
    #  • "No member is currently being served."
    #  • "The member does not have book id.”
  end

  def check_in *book_numbers # * = 1..n of book numbers
    # The book is being returned by the current member (there must be
    # one!), so return it to the collection and remove it from the set of
    # books currently checked out to the member. The book_numbers are
    # taken from the list printed by the search command. Checking in a
    # Book will involve both telling the Book that it is checked in and
    # returning the Book to this library's collection of available Books.
    # If successful, returns "name_of_member has returned n
    # books.”.
    # May throw an Exception with an appropriate message:
    #  • "The library is not open."
    #  • "No member is currently being served."
    #  • "The member does not have book id.”
    #  • A multiline string, each line containing one book (as returned
    #    by the book's to_s method.)
  end

  def check_out *book_ids # 1..n book_ids
    # Checks out the book to the member currently being served (there
    # must be one!), or tells why the operation is not permitted. The
    # book_ids could have been found by a recent call to the search
    # method. Checking out a book will involve both telling the book that
    # it is checked out and removing the book from this library's collection
    # of available books.
    # If successful, returns "n books have been checked out to
    # name_of_member.".
    # May throw an Exception with an appropriate message:
    #  • "The library isnot open."
    #  • "No member is currently being served."
    #  • "The library does not have bookid."
  end

  def renew *book_ids # 1..n book_ids
    # Renews the books for the member currently being served (by setting
    # their due dates to today's date plus 7) or tells why the operation is not
    # permitted.
    # If successful, returns "n books have been renewed for
    # name_of_member.".
    # May throw an Exception with an appropriate message:
    #  • "The library is not open."
    #  • "No member is currently being served."
    #  • "The member does not have book id."
  end

  def close
    # Shut down operations and go home for the night. None of the other
    # operations (except quit) can be used when the library is closed.
    # If successful, returns the string "Good night.".
    # May throw an Exception with the message "The library is
    # not open.”
  end

  def quit
    # The mayor, citing a budget crisis, has stopped all funding
    # for the library.
    
    # Can happen at any time. Returns the string "The library is now
    # closed for renovations.”.
  end

  #-----------------------------------------------------------------------------
  # NOTES
  #-----------------------------------------------------------------------------

  #  1. If you have not already done so, serve the member. This will print a
  #     numbered list of books checked out to that member.
  #  2. check_in the books by the numbers given above.
  #
  #
  # To check books out:
  #
  #  1. If you have not already done so, serve the member. You can ignore
  #     the list of books that this will print out.
  #  2. search for a book wanted by the member (unless you already know
  #     its id).
  #  3. check_out zero or more books by the numbers returned from the
  #     search command.
  #  4. If more books are desired, you can do another search.

  #-----------------------------------------------------------------------------

end
