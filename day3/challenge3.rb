#!/usr/bin/env ruby
require "matrix"
#require "math"

#update matrix class
class Matrix
  def []=(i, j, x)
    @rows[i][j] = x
  end
end

class Challenge3

	def initialize(value=265149)
		@value=value
	end

	def find_lower_bound_square(value_=@value)
		search_ = (value_).to_i
		(2..search_).each { |x| return x-1 if x**2 >= @value}
	end
	
	def bound(index)
		bound = 2
		if index % 2 != 0
			bound = 1
		end
		return bound
	end

	def get_index_of_start_spiral(index, value_=@value)
		bound_ = bound(index)
		if bound_ == 2
			return [index/2, index/2]
		else
			next_pow = (index + 1) ** 2
			if next_pow - value_ <= index
			  	return [index/2 +1, index/2 ]
			else
				return [index/2 , index/2]  
			end	
		end		
	end

	def compute_position(index, value_=value)
		bound_ = bound(index)
		if bound_ == 2
			index1_ = index ** 2
			index2_ = (index+1) ** 2
			index3_ = (index+2) ** 2
			if index1_ + (index + 1) >= value_
				return [value_ - index1_ - 1  ,0]
			else
				return [index, value_ - (index2_ - index)]
			end
		else
			index2_ = index ** 2
			index3_ = (index+1) ** 2
			if index2_ + index  >= value_
				return [index2_ + index - value_  , index]
			else
				return [0, index3_ - value_ ]
			end
		end

	end

	def getManhattanDistance(index_start, index_target)
		return ((index_start[0] - index_target[0]).abs + (index_start[1] - index_target[1]).abs)
	end

	def compute_task2(index_target)
		sum = 	m[index_target[0]-1][index_target[1]-1] +
				m[index_target[0]][index_target[1]-1] 	+
				m[index_target[0]+1][index_target[0]-1] +
				m[index_target[0]-1][index_target[0]] 	+
				m[index_target[0]-1][index_target[0]+1] +
				m[index_target[0]+1][index_target[0]+1] +
				m[index_target[0]][index_target[0]+1] 	+
				m[index_target[0]-1][index_target[0]+1]
		return sum
	end

end


if __FILE__ == $0
	#input = 265149
	#input = 1024
	input = 10

	challenge3 	= Challenge3.new(input)
	size_m 		= challenge3.find_lower_bound_square(input)
	pos1 		= challenge3.get_index_of_start_spiral(size_m)
	pos_target 	= challenge3.compute_position(size_m, input)
	printf("%s\n", pos_target)
	dist        = challenge3.getManhattanDistance(pos1, pos_target)
	#puts dist

	#Task2



end
