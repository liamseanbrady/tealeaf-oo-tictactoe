# Problem Scope:

# Create an object-oriented tic tac toe game.

# Requirements:

# - Tic tac toe is a game played between two players.
# - Each player takes a turn, until either someone has won (3 identical pieces across, 3 identical pieces down, 3 identical pieces diagonal each way), or the board is full with pieces (this is a tie). 
# - One player is assigned X, and one player is assigned O.
# - The game is played on a surface on which a 'board' is drawn.

# Nouns - Game, Player, Piece, Board

# Verbs - play, take a turn, won, tie, assign x, assign o, draw board.

class BoardView
  attr_reader :model

  def initialize(m)
    @model = m
  end

  def display_board
    self.clear_screen

    puts ""
    puts " #{self.model["1"]} | #{self.model["2"]} | #{self.model["3"]}"
    puts "---+---+---"
    puts " #{self.model["4"]} | #{self.model["5"]} | #{self.model["6"]}"
    puts "---+---+---"
    puts " #{self.model["7"]} | #{self.model["8"]} | #{self.model["9"]}"
    puts ""
  end

  def clear_screen
    system "clear"
  end

  def display_board_w_winner(w)
    self.display_board
    puts ""
    if w != nil
      puts "#{w} won!"
    else
      puts "It's a tie!"
    end
    puts ""
  end
end

class BoardModel
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
    empty_squares.sample[0]
  end

  def full?
    self.board.values.include?(" ") ? false : true
  end

  def half_full?
    empty_squares.count < 5
  end

  def to_s
    puts "The board currently looks like #{self.board}"
  end

  private

  def empty_squares
    sqrs = self.board.to_a
    empt_sqrs = sqrs.select{ |sqr| sqr[1] == " " }
  end

end

class Player
  attr_accessor :name
  attr_reader :board_model, :piece

  def initialize(n, b)
    @name = n
    @board_model = b
  end
end

class Human < Player
  def initialize(n, b)
    super(n, b)
    @piece = "X"
  end

  def choose_name
    puts "What's your name?"
    n = gets.chomp
    if !n.empty?
      self.name = n
    end
  end

  def place_piece
    begin
      puts "Please pick a square to place your piece (1 - 9)"
      sqr_num = gets.chomp
    end until self.board_model.square_empty?(sqr_num)

    self.board_model.fill_square(sqr_num, self.piece)
  end
end

class Computer < Player
  def initialize(n, b)
    super(n, b)
    @piece = "O"
  end

  def place_piece
    empty_sqr = board_model.empty_square
    board_model.fill_square(empty_sqr, self.piece)
  end
end

class Game
  WIN_OPTNS = [ ["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"], 
                ["1", "4", "7"], ["2", "5", "8"], ["3", "6", "9"], 
                ["1", "5", "9"], ["3", "5", "7"] ]

  attr_accessor :winner
  attr_reader :board_model, :human, :computer, :board_view

  def initialize
    @board_model = BoardModel.new
    @board_view = BoardView.new(self.board_model.board)
    @human = Human.new("Anonymous", self.board_model)
    @computer = Computer.new("C3P0", self.board_model)
    @winner = nil
  end

  def play
    human.choose_name
    board_view.display_board
    begin
      human.place_piece
      break if board_model.full? || winner?
      computer.place_piece
      board_view.display_board
    end until board_model.full? || winner?
    board_view.display_board_w_winner(winner)
  end

  def winner?
    if board_model.half_full?
      WIN_OPTNS.each do |w|
        if board_model.board.values_at(*w).count("X") == 3
          self.winner = "#{human.name}"
          return true
        elsif board_model.board.values_at(*w).count("O") == 3
          self.winner = "#{computer.name}"
          return true
        end
      end
      return false
    end
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
# Should check if there is a winner
# Should display who the winner is
# Create UI to display the results
# Should check if there is a winner
# Should display winner from BoardView class
# Should perform system "clear" from BoardView class
# Should allow user to choose their name
