require_relative 'board'
require_relative 'piece'

class Game

	def initialize
		@board = Board.new
		@player1 = Player.new(:white)
		@player2 = Player.new(:red)
	end


	def play
		current_player = @player1
		until gameover?(@player1) || gameover?(@player2)
			puts "#{current_player.color.capitalize}'s Turn \n\n"

		#begin
			@board.display_board

			@board[current_player.get_starter].perform_moves!(current_player.get_moves)
			#check validity
		#rescue 

		current_player = current_player == @player1 ? @player2 : @player1
		end
		@board.display_board
	end

	def gameover?(player)
	end


end

class Player

	attr_accessor :color
	def initialize(color)
		@color = color
	end

	def get_starter
		print "Which piece would you like to move?"
			gets.chomp.split(',').map { |i| i.to_i }
	end

	def get_moves
		print "Where would you like to move?"
			gets.chomp.split(',').map { |i| i.to_i }
	end

end

if $PROGRAM_NAME == __FILE__
  new_game = Game.new
  new_game.play
end