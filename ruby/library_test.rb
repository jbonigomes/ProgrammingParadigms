
require_relative 'library.rb'

# Mock a Library
library = Library.instance

# Mock a Calendar
calendar = Calendar.instance

# Mock some Books
book_id = 0
books   = Hash.new

File.open('collection.txt').each do |line|
      
  book_id += 1

  title, author = line.split(/, /)

  books[book_id] = Book.new book_id, title, author

end

# Mock some Members
member_1 = Member.new 'Oliver', library
member_2 = Member.new 'Jack', library
member_3 = Member.new 'Charlie', library
member_4 = Member.new 'Emily', library
member_5 = Member.new 'Chloe', library
