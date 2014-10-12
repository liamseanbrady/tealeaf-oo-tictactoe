# Problem Scope:

# Create an object oriented tic tac toe game.

# Requirements:

# - Tic tac toe is a game played between two players.
# - Each player takes a turn, until either someone has won (3 identical pieces across, 3 identical pieces down, 3 identical pieces diagonal each way), or the board is full with pieces (this is a tie). 
# - One player is assigned X, and one player is assigned O.
# - The game is played on a piece of paper on which a 'board' is drawn.

# Nouns - Game, Player, Piece, Board

# Verbs - play, take a turn, won, tie, assign x, assign o, draw board.

require "pry"

class Board
  attr_accessor :board

  def initialize
    @board = {"1" => " ", "2" => " ", "3" => " ",  "4" => " ", "5" => " ", "6" => " ", "7" => " ", "8" => " ", "9" => " "}
  end

  def square_empty?(sqr_num)
    self.board[sqr_num] == " "
  end

  def fill_square(sqr_num, piece)
    self.board[sqr_num] = piece
  end

  def empty_square
    sqrs = self.board.to_a
    empt_sqrs = sqrs.select{ |sqr| sqr[1] == " " }
    empt_sqrs.sample[0]
  end

  def full?
    self.board.values.include?(" ") ? false : true
  end

  def to_s
    puts "The board currently looks like #{self.board}"
  end
end

class Human
  attr_reader :name, :board, :piece

  def initialize(n, b)
    @name = n
    @board = b
    @piece = "X"
  end

  def place_piece
    begin
      puts "Please pick a square to place your piece (1 - 9)"
      sqr_num = gets.chomp
    end until self.board.square_empty?(sqr_num)

    self.board.fill_square(sqr_num, self.piece)
  end
end

class Computer
  attr_reader :name, :board, :piece

  def initialize(n, b)
    @name = n
    @board = b
    @piece = "O"
  end

  def place_piece
    empty_sqr = board.empty_square
    board.fill_square(empty_sqr, self.piece)
  end
end

class Game
  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Human.new("Ingin", self.board)
    @computer = Computer.new("C3P0", self.board)
  end

  def play
    begin
      human.place_piece
      break if self.board.full?
      computer.place_piece
      puts board
    end until self.board.full?
  end
end

game = Game.new.play

# Should start Game
# Should play game
# Should assign X to human player
# Should allow human player to place their piece
# Should create board with 9 squares
# Should check if square on board is empty
# Should fill chosen square with player's assigned piece
# Should allow computer player to place their piece
# Should check before each player moves whether the board is full
# Should exit the loop if the board is full



