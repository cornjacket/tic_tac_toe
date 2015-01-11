#tic tac toe
#
# future feature could be to prompt user to start another game after previous 
# game finishes.
#
# Board class maintains data structure for tic-tac-toe
# and provides interface for Game class
class Board
  
  OPEN = "_"

  def initialize
  	@occupied_spaces = 0
    @board = Hash.new(:invalid)
    (1..3).each { |row| (1..3).each { |col| @board[:row => row, :col => col] = OPEN } }
  end

  def display
  	printf "\n"
    (1..3).each do |row| 
    	(1..3).each { |col| printf "#{@board[:row => row, :col => col]} " }
    	printf "\n"
    end
    puts
  end

  def mark(row, col, piece)
    if valid?(row,col)
      @board[:row => row, :col => col] = piece
      @occupied_spaces += 1
      true
    else
      false
    end
  end

  def valid?(row, col)
    (@board[:row => row, :col => col] == OPEN)    
  end

  def full?
    (@occupied_spaces >= 9)  
  end

  def winner?(piece)
    # iterate through rows
    (1..3).each do |row| 
    	match = true
    	(1..3).each { |col| match=false unless @board[:row => row, :col => col] == piece }
    	return true if match == true
    end
    # iterate through columns
    (1..3).each do |col| 
    	match = true
    	(1..3).each { |row| match=false unless @board[:row => row, :col => col] == piece }
    	return true if match == true
    end
    # check downward diagonal
    match = true
     (1..3).each do |row|
        col = row 
    	match=false unless @board[:row => row, :col => col] == piece
    end   
    return true if match == true
    # check upward diagonal
    match = true
     (1..3).each do |row|
        col = 4-row 
    	match=false unless @board[:row => row, :col => col] == piece
    end   
    return true if match == true    
    # if we get here, then there is no three in a row of piece
    false
  end


end

#game class which keeps track of whose turn it is and does an infinite loop.
#  displays messages
#  determines who is the winner
class Game

  def initialize
    puts "Welcome to Tic-Tac-Toe\n"
    @player1        = "X"
    @player2        = "O"
    @board          = Board.new
  end

  def get_input(player)
    puts "#{player}'s turn. Enter row, col to mark an #{player}"    
    row, col = gets.chomp.split(",").map { |i| i.to_i }
      while !@board.valid?(row,col)
      	puts "Invalid entry. Please retry."
        puts "#{player}'s turn. Enter row, col to mark an #{player}"    
        row, col = gets.chomp.split(",").map { |i| i.to_i }      	
      end
    [row, col]
  end

  def next_player(player)
    (player == @player1) ? @player2 : @player1
  end

  def play
    game_won  = false
    current_player = @player1    
    @board.display

    while !game_won && !@board.full?
      row, col = get_input(current_player)
      @board.mark(row, col, current_player)
      @board.display
      game_won = @board.winner?(current_player)
      current_player = next_player(current_player) unless game_won
    end # while !game_over

    puts (game_won) ? "Congrat's Player #{current_player}! You have won the game!!"
                    : "Game is a draw. :("
  end # def play

end # class Game

game = Game.new
game.play
