class Piece

	attr_accessor: promoted

	def initialize(color, promoted = false)
		@color = color
		@promoted = promoted
	end
end