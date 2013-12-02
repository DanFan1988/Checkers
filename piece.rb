require_relative 'board'
require_relative 'exceptions'
require 'debugger'

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
			 return true
		end
		return false
	end

	def perform_jump(pos)
		jumped_piece =  jump_direction(pos)
		if jump_moves.include?([@position[0]-pos[0],@position[1]-pos[1]]) && @board[jumped_piece].color != self.color
			@board[pos] = @board[@position]
			@board[@position] = nil
			@position = pos
			@board[jumped_piece] = nil
			return true
		end
		return false
	end

	def jump_direction(pos)
		x,y = pos
		if @position[0] > pos[0]
			x+=1
		else
			x-=1
		end

		if @position[1] > pos[1]
			y+=1
		else
			y-=1
		end
		[x,y]
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

	def perform_moves(move_sequence)
	  valid_move_seq?(self.position, move_sequence)

		perform_moves!(move_sequence)
	end

	def perform_moves!(move_sequence)

		if move_sequence.count == 1
			mover = (perform_slide(move_sequence.flatten) || perform_jump(move_sequence.flatten))
			raise InvalidMoveError.new("Invalid Jump") if mover == false
		end

		if move_sequence.length > 2
			move_sequence.each do |move|
				raise InvalidMoveError.new("Invalid Jump") if perform_jump(move) == false
			end
		end
	end

	def valid_move_seq?(piece, move_sequence)
		duped_board = @board.dup
		duped_board[piece].perform_moves!(move_sequence)
	end

	def to_s
		return "O".colorize(:color => @color)
	end
end