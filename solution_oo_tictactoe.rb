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
  attr_reader :data

  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

  def initialize
    @data = {}
    (1..9).each { |position| @data[position] = Square.new(" ") }
  end

  def draw
    system "clear"

    puts ""
    puts " #{@data[1]} | #{@data[2]} | #{@data[3]}"
    puts "---+---+---"
    puts " #{@data[4]} | #{@data[5]} | #{@data[6]}"
    puts "---+---+---"
    puts " #{@data[7]} | #{@data[8]} | #{@data[9]}"
    puts ""
  end

  def all_squares_marked?
    empty_squares.size == 0
  end

  def empty_squares
    data.select{ |_, sqr| sqr.occupied? }.values
  end

  def empty_positions
    data.select{ |_, sqr| sqr.empty? }.keys
  end

  def mark_square(pos, marker)
    data[pos].mark(marker)
  end

  def winning_condition?(marker)
    WINNING_LINES.each do |line|
      return true if @data[line[0]].value == marker && @data[line[1]].value == marker && @data[line[2]].value == marker
    end
    false
  end
end

class Square
  attr_accessor :value

  def initialize(value)
    @value = value
  end

  def mark(marker)
    self.value = marker
  end

  def occupied?
    @value != " "
  end

  def empty?
    @value == " "
  end

  def to_s
    @value
  end
end

class Player
  attr_reader :name, :marker

  def initialize(n, m)
    @name = n
    @marker = m
  end
end

class Game
  def initialize
    @board = Board.new
    @human = Player.new("Ingin", "X")
    @computer = Player.new("C3PO", "O")
    @current_player = @human
  end

  def current_player_marks_square
    if @current_player == @human
      begin
        puts "Choose a position (1-9):"
        position = gets.chomp.to_i
      end until @board.empty_positions.include?(position)
    else
      position = @board.empty_positions.sample
    end
    @board.mark_square(position, @current_player.marker)
  end

  def alternate_player
    if @current_player == @human
      @current_player = @computer
    else
      @current_player = @human
    end
  end

  def current_player_win?
    @board.winning_condition?(@current_player.marker)
  end

  def play
    @board.draw
    loop do
      current_player_marks_square
      @board.draw
      if current_player_win?
        puts "The winner is #{@current_player.name}"
        break
      elsif @board.all_squares_marked?
        puts "It's a tie!"
        break
      else
        alternate_player
      end
    end
    puts "Bye!"
  end
end

Game.new.play

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

