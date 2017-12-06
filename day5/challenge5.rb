#!/usr/bin/env ruby
require "test/unit/assertions"
require "solid_assert"
def process_line(line)
	return line.split(" ").map(&:to_i)
end

def errbody_jump(list)
	position 	= 0
	counter 	= 1
	while position < list.length
		ofst 	 = position
		position += list[position]
		counter += 1
		if list[ofst] >=3
			list[ofst] -= 1
		else
			list[ofst] += 1
		end
		
		printf("%s\n", position)
	end
	#printf("%s\n", counter)
	return counter - 1
end

def task5(code)
	counter = 0
	for step in 1..666666677777
		counter2 = counter
		counter += code[counter]
		code[counter2] +=1
		printf("%s\n", counter)
		if counter >= code.length
			return step
		end
	end
end



def parse_file
	opcode = []
	File.open("input", 'r').each do |instruction|
		opcode.push(process_line(instruction)[0])	
	end
	return opcode		
end

if __FILE__ == $0
	opcode = parse_file
	printf("%s\n", opcode)
	assert errbody_jump([0, 3,  0,  1,  -3]) == 5, "[-] Test failed."
	puts errbody_jump(opcode)
	
end