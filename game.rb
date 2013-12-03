require_relative 'board'
require_relative 'piece'
require_relative 'exceptions'

class Game

	def initialize
		@board = Board.new
		@player1 = Player.new(:white)
		@player2 = Player.new(:red)
	end


	def play
		current_player = @player1
		until gameover?
			
			begin
				puts "#{current_player.color.capitalize}'s Turn \n\n"
				@board.display_board
				starting_pos = current_player.get_starter
				ending_pos = current_player.get_moves
				raise InvalidMoveError.new("You didn't pick a piece") if @board[starting_pos].nil?
				if @board[starting_pos].color != current_player.color
					raise InvalidMoveError.new("That piece is not your color")
				end
				@board[starting_pos].perform_moves(ending_pos)
			rescue InvalidMoveError => error
				puts error.message
				retry
			end

			current_player = current_player == @player1 ? @player2 : @player1
		end
		@board.display_board
	end

	def gameover?
		all_red = @board.pieces.none? { |piece| piece.color == :red }
		all_white = @board.pieces.none? { |piece| piece.color == :white }
		all_red || all_white
	end


end

class Player

	attr_accessor :color
	def initialize(color)
		@color = color
	end

	def get_starter
		print "Which piece would you like to move?"
		move = gets.chomp.split(',').map { |i| i.to_i }
		raise InvalidMoveError.new("Out Of Bounds. Try again") if out_of_bounds?(move)
		#	raise InvalidMoveError.new("NOt yor piece") if your_piece?(move)
		move
	end

	def get_moves
		moves = []
		move = ""
		while true
		print "Where would you like to move? Please input 1 move at a time. Type '0' when finished. "
			move = gets.chomp.split(',').map { |i| i.to_i }
			break if move == [0]
			raise InvalidMoveError.new("Out of bounds. Try again.") if out_of_bounds?(move)
			moves << move
		end
		moves
	end

	def out_of_bounds?(move)
		move.max > 7 || move.min < 0
	end
end

if $PROGRAM_NAME == __FILE__
  new_game = Game.new
  new_game.play
end