class Game

	def initialize
		@board = Board.new
		@player1 = Player.new(:red)
		@player2 = Player.new(:black)
		set_up_board
	end

	def set_up_board
		(0..2).each do |row|
			


end

class Player
	def initialize(color)
		@color = color
	end

	def play_turn
	end

end