require_relative 'piece'
require 'colorize'

class Board

	attr_accessor :grid

	def initialize
		@grid = Array.new(8) { Array.new(8)}
		set_up_board
	end

	def [](pos)
		x,y = pos
		@grid[x][y]
	end

	def []=(pos, future)
		x,y = pos
		@grid[x][y] = future
	end
		

	def set_up_board
		(0..2).each do |row|
			8.times do |col|
				if (row.even? && col.odd?) || (row.odd? && col.even?)
					@grid[row][col] = Piece.new(self, :red, [row, col])
				end
			end
		end

		(5..7).each do |row|
			8.times do |col|
				if (row.even? && col.odd?) || (row.odd? && col.even?)
					@grid[row][col] = Piece.new(self, :white, [row, col])
				end
			end
		end
	end

	def display_board
		puts "   0 1 2 3 4 5 6 7"
		puts
		@grid.each_with_index do |row, index|
      print "#{index}  "
      row.each do |spot|
				if spot.nil?
					print "_ "
				else
					print "#{spot.to_s} "
				end
			end
			puts
		end
	end
end