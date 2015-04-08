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

book_not_in_library = Book.new 99, 'A bogus book', 'A famous author'


# Mock a Library
Library.books    = books 
Library.calendar = calendar
Library.members  = Hash.new

library = Library.instance


# Mock some Members
members = Hash.new

members[0] = Member.new 'Oliver'
members[1] = Member.new 'Jack'
members[2] = Member.new 'Charlie'
members[3] = Member.new 'Emily'
members[4] = Member.new 'Chloe'


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


# add a member
library.issue_card members[0]


# try to add a member twice
# library.issue_card members[0]


# serve a member that does not have a library card
# library.serve members[1]


# no member being served
# library.check_in 1
# library.check_out 1
# library.renew 1


# serve a member
library.serve members[0]


# check out a book that does not exist
# library.check_out book_not_in_library


# checkout 5 real books
library.check_out books[0], books[5], books[10], books[15], books[20]


# check a couple of book back in
library.check_in members[0].books[0], members[0].books[5]


# renew a couple of books
library.renew members[0].books[10], members[0].books[15]


# find all overdue books
puts library.find_all_overdue_books


# the member does not have book id


# find_overdue_books
library.find_overdue_books


# close
# quit
