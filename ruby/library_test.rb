
require_relative 'library.rb'

lib = Library.instance

puts lib.open



# Todo

# Implement the remainder of the methods
# Write the tests



# Questions

# should the library card be a unique number or a boolean will suffice?

# should I use a ruby gem for testing or can I write my own tests in plain ruby?

# don't understand this thing of making the current member nil when a new
# Library is created, in fact, it is not clear to me how and when members will
# be created, to my mind, Library should have a method to do so, adding this new
# member to the array of members that belong to the Library class



# NOTES

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
