#!/usr/bin/env ruby
#define class Challenge2

class Challenge2

	def initialize(input_ = "input")
		@input_ = input_
	end
	
	#task1: min/max checksum	
	def process_string(line)
		return line.split("\t").map{|x| x.chomp}.map(&:to_i)
	end

	def solve1
		_checksum_ = 0	
		File.open(@input_, 'r').each do |line|
			tmp_list 	= process_string(line).minmax
			_checksum_ += tmp_list.last - tmp_list.first
		end

		return _checksum_	
	end

	#task2: evenly divisible values checksum
	def isdiv?(a,b)
		return a % b == 0
	end

	def parse_div(list)
		list.each do |y|
			list.each { |x| return x/y if isdiv?(x, y) && x != y}
 		end
 		return 0
	end

	def solve2
		_checksum_ = 0	
		File.open(@input_, 'r').each do |line|
			tmp_list 	= process_string(line).sort.reverse
			tmp_list 	= tmp_list.each { |k| tmp_list.delete(k) if k == 1 || k == 0 }
			#printf("%s\n", parse_div(tmp_list))
			_checksum_ += parse_div(tmp_list)
		end
		return _checksum_	
	end
end


if __FILE__ == $0

	challenge = Challenge2.new("input")
	printf("[+] Checksum is: %d\n" , challenge.solve1)
	#challenge.solve2
	printf("[+] Checksum is: %d\n" , challenge.solve2)
end

