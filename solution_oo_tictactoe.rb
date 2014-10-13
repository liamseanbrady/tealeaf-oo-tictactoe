# What is a Tic Tac Toe game?

# A board game with two players. We start with an empty 3 x 3 board.
# One player is X, the other player is O.
# The 'X' player goes first.
# Two players alternate to mark empty squares.
# Alternate turns until a player gets 3 squares in a row.
# If all squares are marked and nobody won, then it's a tie.

# Nouns: Board, Players, X, O, Squares
# Verbs: start, go, mark, turn, tie, won
# States: empty, 3 squares in a row

class Board

  def initialize
    @data = {}
    (1..9).each { |position| @data[position] = Square.new(" ") }
  end

  def draw
    puts "Drawing...board..."
    puts @data.inspect
  end

  # - all squares marked?
  # - find all empty squares
end

class Square
  def initialize(value)
    @value = value
  end
end

board = Board.new
board.draw

# player1
#   - name
#   - marker

# squares
#   - occupied?
#   - mark(marker)

# game engine
#   draw a board

#   assign player to "X"
#   assign computer to "O"

#   loop until a winner or all squares are taken
#     player picks an empty square
#     check for a winner
#     computer picks and empty square
#     check for a winner

#   if there's a winner
#     show the winner
#   or else
#      it's a tie

