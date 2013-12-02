require_relative 'board'

class Piece

	SLIDES_W = [
		[ 1, 1],
		[ 1,-1]
	]

	SLIDES_B = [
		[-1, 1],
		[-1,-1]
	]

	JUMPS_W = [
		[ 2, 2],
		[ 2,-2]
	]

	JUMPS_B = [
		[-2, 2],
		[-2,-2]
	]

	attr_accessor :promoted, :position, :board
	attr_reader :color

	def initialize(board, color, position, promoted = false)
		@board = board
		@color = color
		@position = position
		@promoted = promoted
	end

	def perform_slide(pos)
		if slide_moves.include?([@position[0]-pos[0],@position[1]-pos[1]])
			 @board[pos] = @board[@position]
			 @board[@position] = nil
			 @position = pos
		end
	end

	def perform_jump(pos)
		jumped_piece =  jump_direction(pos)
		if jump_moves.include?(pos) && @board[jumped_piece].color != self.color
			@board[pos] = @board[@position]
			@board[@position] = nil
			@position = pos
			@board[jump_piece] = nil
		end
	end

	def jump_direction(pos)
		if @position[0] > pos[0]
			[pos[0]+1, pos[1]+1]
		else
			[pos[0]-1, pos[1]-1]
		end
	end

	def slide_moves
		if promoted == true
			SLIDES_W + SLIDES_B
		elsif @color == :white
			SLIDES_W
		else
			SLIDES_B
		end
	end

	def jump_moves
		if promoted == true
			JUMPS_W + JUMPS_B
		elsif @color == :white
			JUMPS_W
		else
			JUMPS_B
		end
	end

	def perform_moves!(move_sequence)
		p move_sequence

		if move_sequence.count == 2
			perform_slide(move_sequence) || perform_jump(move_sequence)
		end

		if move_sequence.length > 2
			move_sequence.each do |move|
				perform_jump(move)
			end
		end
	end

	def to_s
		return "O".colorize(:color => @color)
	end
end