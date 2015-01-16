# Suduko with Racket

### Purposes of this assignment
- To give you experience using the functional programming paradigm and writing a
"real" program in Racket

### General idea

Write a program to solve easy Sudoku puzzles. A puzzle will be considered "easy"
if it can be solved using the algorithm described below.

Here is an example of an easy Sudoku puzzle that you program should be able to
solve.

<table>
	<tbody>
		<tr>
			<td align="center"></td>
			<td align="center">2</td>
			<td align="center">5</td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center">1</td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center"></td>
		</tr>
		<tr>
			<td align="center">1</td>
			<td align="center"></td>
			<td align="center">4</td>
			<td align="center">2</td>
			<td align="center">5</td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center"></td>
		</tr>
		<tr>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center">6</td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center">4</td>
			<td align="center">2</td>
			<td align="center">1</td>
			<td align="center"></td>
		</tr>
		<tr>
			<td align="center"></td>
			<td align="center">5</td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center">3</td>
			<td align="center">2</td>
			<td align="center"></td>
		</tr>
		<tr>
			<td align="center">6</td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center">2</td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center">9</td>
		</tr>
		<tr>
			<td align="center"></td>
			<td align="center">8</td>
			<td align="center">7</td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center">6</td>
			<td align="center"></td>
		</tr>
		<tr>
			<td align="center"></td>
			<td align="center">9</td>
			<td align="center">1</td>
			<td align="center">5</td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center">6</td>
			<td align="center"></td>
			<td align="center"></td>
		</tr>
		<tr>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center">7</td>
			<td align="center">8</td>
			<td align="center">1</td>
			<td align="center"></td>
			<td align="center">3</td>
		</tr>
		<tr>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center">6</td>
			<td align="center"></td>
			<td align="center"></td>
			<td align="center">5</td>
			<td align="center">9</td>
			<td align="center"></td>
		</tr>
	</tbody>
</table>

### How to play

Fill in the grid so that every row, every column and every 3x3 box contains the
digits 1-9. There is no math involved. You solve the puzzle with reasoning and
logic.

### Details

The following two functions are required:

		(solve matrix)

accepts a Sudoku puzzle given as a list of lists, with each sub-list
representing one row of the puzzle. The elements of the sub-list are the
integers shown in the puzzle, but with 0 representing a blank space. Thus, the
above puzzle would be represented as

		[[0 2 5 0 0 1 0 0 0] ... [0 0 0 6 0 0 5 9 0]]

The value returned by `solve` will be a similar list of lists, but with all the
zeros replaced by the appropriate numbers 1..9. (Any unsolved locations -- there
shouldn't be any — will be a set of the digits that might be there.)

		(transform matrix)

takes a Sudoku puzzle in the above list of lists format, and replaces each
integer with a set of integers, thus returning a list of sets of integers. Zeros
in the matrix are replaced by the set

		{1 2 3 4 5 6 7 8 9}

and each nonzero number is replaced by a set containing only that number. (You
can think of these as the set of "possible" numbers for this location.)

You will probably find it most convenient to work with a list of sets
implementation, and in any case you are required to write the above two
functions. If you prefer to work with some other implementation, you are free to
transform the matrix internally to whatever form you choose.


### The algorithm

- Repeatedly do the following:
	- Find a location containing a singleton set (a set containing just one
	number).
		- For every other set in the same row, the same column, or the same 3x3
		box, remove that number (if present).
	- Find a number in a set that does not occur in any other set in the same
	row (or column, or box).
		- Reduce that set to a singleton containing that one number.
- Quit when every set is a singleton, or when no more numbers can be removed
from any set.

### Testing

Write, in a separate file, unit tests for all your methods. We will also use our
own unit tests for the two required methods.
