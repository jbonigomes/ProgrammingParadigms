# Get our library
require_relative 'library.rb'

# Mock a Calendar
calendar = Calendar.instance

# Mock some Books
book_id = 0
books   = Hash.new

File.open('collection.txt').each do |line|
  title, author = line.split(/, /)
  books[book_id] = Book.new book_id, title, author
  book_id += 1
end

# Mock a Library
Library.books    = books 
Library.calendar = calendar
Library.members  = Hash.new

library = Library.instance

# Mock some Members
members = Hash.new

members[0] = Member.new 'Oliver', library
members[1] = Member.new 'Jack', library
members[2] = Member.new 'Charlie', library
members[3] = Member.new 'Emily', library
members[4] = Member.new 'Chloe', library

# time to ensure all classes have been created and work

# calendar
# puts calendar.date

# calendar.advance

# puts calendar.date

# book
# puts books[0].to_s
# puts books[0].due_date

# books[0].check_out 7
# puts books[0].due_date

# books[0].check_in
# puts books[0].due_date

# member
# puts members[0].name
# puts members[0].books

# members[0].check_out books[0]

# puts members[0].books[0].to_s

# members[0].give_back books[0]

# puts members[0].books

# puts members[0].send_overdue_notice 'You\'ve been warned!'


# ok, our library is now closed
# let's make sure it raises the library not open exceptions

# library.find_all_overdue_books
# library.issue_card members[0].name
# library.serve members[0].name
# library.find_overdue_books
# library.check_in
# library.check_out
# library.renew
# library.close


# let's open the library and try to raise the other errors
puts library.open


# try to open a library that is already open
# library.open


# the library does not have book id
# will test this later


# try to add a member twice
library.issue_card members[0]
# library.issue_card members[0]


# serve a member that does not have a library card
# library.serve members[1]
library.serve members[0]


# no member being served exception test
library.find_overdue_books
# library.check_in
# library.check_out
# library.renew


# find all overdue books
# puts library.find_all_overdue_books


# find_overdue_books
# check_in
# check_out
# renew


# close
# quit
