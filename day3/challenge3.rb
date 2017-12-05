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
		(1..search_).each { |x| return x-1 if x**2 >= @value}
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

	def compute_position(index, value_=@value)
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
	def neib_sum(m,i,j)
		sum = 	m[i-1][j-1].to_i +
				m[i][j-1].to_i 	+
				m[i+1][j-1].to_i +
				m[i+1][j].to_i 	+
				m[i+1][j+1].to_i +
				m[i][j+1].to_i +
				m[i-1][j+1].to_i +
				m[i-1][j].to_i
		return sum
	end

	def spiral(n)
  		spiral = Array.new(n) {Array.new(n, 0)}     
  		runs = 0.upto(n).each_cons(2).to_a.flatten  # n==5; [5,4,4,3,3,2,2,1,1,0]
  		delta = [[1,0], [0,1], [-1,0], [0,-1]].cycle
  		x, y, value = n/2, n/2, 1
  		spiral[n/2][n/2] = 1
  		for run in runs
    		dx, dy = delta.next
    		run.times { spiral[x+=dx][y+=dy] = (value+=1) }
 		end
  		spiral
	end

	def print_matrix(m)
		width = m.flatten.map { |x| x.to_s.size }.max 
		m.each{ |row| puts row.map { |x| "%#{width}s " % x }.join}
	end


	def spiral2(n, stop_val)
  		spiral = Array.new(n) {Array.new(n, 0)}   
  		runs = 0.upto(n).each_cons(2).to_a.flatten  
  		delta = [[1,0], [0,1], [-1,0], [0,-1]].cycle
  		x, y, value = n/2, n/2, 1
  		spiral[n/2][n/2] = 1
  		for run in runs
    		dx, dy = delta.next
    		run.times { 
      			if ((x == n/2) && (y == n/2)) 
        			#spiral[x+=dx][y+=dy] =  1
        			spiral[x+=dx][y+=dy] = 1
      			else
        			value = neib_sum(spiral,x+=dx,y+=dy)
        			#printf("value %s\n", value)
        			spiral[x][y] = value
        			if value > stop_val
          				return value
          				break
        			end
      			end
     		#print_matrix spiral 
      		} 
  		end
  		spiral
  
	end
end


if __FILE__ == $0
	input = 265149
	#input = 1024
	#input = 31

	challenge3 	= Challenge3.new(input)
	size_m 		= challenge3.find_lower_bound_square(input)
	pos1 		= challenge3.get_index_of_start_spiral(size_m)
	pos_target 	= challenge3.compute_position(size_m, input)
	dist = challenge3.getManhattanDistance(pos1, pos_target)
	printf("%s\n", pos_target)
	printf("Distance: %s\n", dist)

	#Task2

	task2 = challenge3.spiral2(size_m, input) 
	puts task2
end
