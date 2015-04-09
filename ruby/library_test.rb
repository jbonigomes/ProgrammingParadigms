# Some colours magic
# http://stackoverflow.com/questions/2070010
def colorize text, color_code
  "\e[#{color_code}m#{text}\e[0m"
end

def tst test
  if test
    return colorize 'PASSED', 32
  end

  colorize 'FAILED', 31
end


# Get our library
require_relative 'library.rb'


# Mock a Calendar
calendar = Calendar.instance


# Mock some Books
book_id = 0
books   = Hash.new

File.open('collection.txt').each do |line|
  title, author = line.split(/, /)
  books[book_id] = Book.new book_id, title.strip, author.strip
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
puts "Calendar date = 0: #{tst(calendar.date.eql?(0))}"

calendar.advance
puts "Calendar date = 1: #{tst(calendar.date.eql?(1))}"


# book
firstbook = "0: The Miniaturist, by Jessie Burton"
puts "First book = #{firstbook} #{tst(firstbook.eql?(books[0].to_s))}"

puts "First book due date = nil: #{tst(books[0].due_date.nil?)}"

books[0].check_out 7
puts "First book due date = 7: #{tst(books[0].due_date.eql?(7))}"

books[0].check_in
puts "First book due date = nil: #{tst(books[0].due_date.nil?)}"


# member
puts "First member name = 'Oliver': #{tst(members[0].name.eql?('Oliver'))}"

puts "First member does not have books yet: #{tst(members[0].books.length.eql?(0))}"

members[0].check_out books[0]
puts "First member now has 1 book: #{tst(members[0].books.length.eql?(1))}"

members[0].give_back books[0]
puts "First member does not have books yet: #{tst(members[0].books.length.eql?(0))}"

warning = "You've been warned!"
puts "First member overdue notice = 'Oliver: #{warning}': #{tst(members[0].send_overdue_notice(warning))}"


# ok, our library is now closed
# let's make sure it raises the library not open exceptions

begin
  library.find_all_overdue_books
rescue => e
  error = "The library is not open!"
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end

begin
  library.issue_card members[0].name
rescue => e
  error = "The library is not open!"
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end

begin
  library.serve members[0].name
rescue => e
  error = "The library is not open!"
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end

begin
  library.find_overdue_books
rescue => e
  error = "The library is not open!"
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end

begin
  library.check_in
rescue => e
  error = "The library is not open!"
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end

begin
  library.check_out
rescue => e
  error = "The library is not open!"
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end

begin
  library.renew
rescue => e
  error = "The library is not open!"
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end

begin
  library.close
rescue => e
  error = "The library is not open!"
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end


# let's open the library and try to raise the other errors
libopenstr = 'Today is day 2'
puts "Open library returns '#{libopenstr}': #{tst(library.open.eql?(libopenstr))}"


# try to open a library that is already open
begin
  library.open
rescue => e
  error = "The library is already open!"
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end


# add a member
newmemberstr = "Library card issued to Oliver."
puts "New member return string '#{newmemberstr}': #{tst(library.issue_card(members[0]).eql?(newmemberstr))}"


# try to add a member twice
begin
  library.issue_card members[0]
rescue => e
  error = "Member already exist"
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end


# serve a member that does not have a library card
begin
  library.serve members[1]
rescue => e
  error = "Member does not have a library card."
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end


# no member being served
begin
  library.check_in books[0], books[1]
rescue => e
  error = "No member is currently being served."
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end

begin
  library.check_out books[0], books[1]
rescue => e
  error = "No member is currently being served."
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end

begin
  library.renew books[0], books[1]
rescue => e
  error = "No member is currently being served."
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end


# serve a member
servingmember = "Now serving Oliver."
puts "Serve member method returns '#{servingmember}': #{tst(library.serve(members[0]).eql?(servingmember))}"


# check out a book that does not exist
begin
  library.check_out book_not_in_library
rescue => e
  error = "The library does not have book id 99"
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end


# checkout 5 real books
bookscheckedout = "5 books have been checked out to Oliver."
puts "Checkout books returns '#{bookscheckedout}': #{tst(library.check_out(books[0], books[5], books[10], books[15], books[20]).eql?(bookscheckedout))}"


# check a couple of book back in
bookscheckedin = "Oliver has returned 2 books."
puts "Checkin books returns '#{bookscheckedin}': #{tst(library.check_in(members[0].books[0], members[0].books[5]).eql?(bookscheckedin))}"


# check in a book we don't have
begin
  library.check_in book_not_in_library
rescue => e
  error = "The member does not have book id 99"
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end


# renew a couple of books
booksrenewed = "2 books have been renewed for Oliver."
puts "Rewew books returns '#{booksrenewed}': #{tst(library.renew(members[0].books[10], members[0].books[15]).eql?(booksrenewed))}"


# renew a book we don't have
begin
  library.renew book_not_in_library
rescue => e
  error = "The member does not have book id 99"
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end


# find all overdue books
nooverduebooks = "Oliver: Books due: No books are overdue"
puts "There are no books overdue: #{tst(library.find_all_overdue_books.eql?(nooverduebooks))}"


# ensure current member does not have overdue books
nooverduebooks = "Oliver: Member Oliver has no books overdue"
puts "Oliver does not have any overdue books: #{tst(library.find_overdue_books.eql?(nooverduebooks))}"


# almost there, let's make sure the overdue books methods print correctly

# add a couple more members
library.issue_card members[1]
library.issue_card members[2]


# advance the calendar by 8 days
calendar.advance
calendar.advance
calendar.advance
calendar.advance
calendar.advance
calendar.advance
calendar.advance
calendar.advance


alloverduebooks = "Oliver: Books due:
\t10: Elisabeth is Missing, by Emma Healey
\t15: The Murder Bag, by Tony Parsons
\t20: Unlucky 13, by James Patterson
Jack: Books due: No books are overdue
Charlie: Books due: No books are overdue"
puts "All overdue books string looks like \n#{alloverduebooks}: #{tst(library.find_all_overdue_books.length.eql?(213))}"


# find_overdue_books
overduebooks = "Oliver: Books due:
\t10: Elisabeth is Missing, by Emma Healey
\t15: The Murder Bag, by Tony Parsons
\t20: Unlucky 13, by James Patterson"
puts "Books by member call returns \n'#{overduebooks}': #{tst(library.find_overdue_books.eql?(overduebooks))}"


# close
closestr = "Good night"
puts "Closing the library returns '#{closestr}': #{tst(library.close.eql?(closestr))}"

begin
  library.find_overdue_books
rescue => e
  error = "The library is not open!"
  puts "#{error}: #{tst(e.to_s.eql?(error))}"
end

# quit
quitstr = "The library is now closed for renovations"
puts "Quitting the library returs '#{quitstr}': #{tst(library.quit.eql?(quitstr))}"
