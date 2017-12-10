#!/usr/bin/env ruby

require "solid_assert"

$database = []

def parse_input() 
	input_list 	= []
	file 		= File.open('input', 'r') {|f| f.read}
	input_list 	= file.split("\t").map(&:to_i)		
	return input_list
end

def redistribute(input_list)
	max_index 	= input_list.index(input_list.max)
	steps 	  	= input_list[max_index]
	input_list[max_index] = 0
	for x in (1..steps)
		input_list[(max_index + x) % input_list.length] += 1
	end
	return	input_list
end

def count_interations(input_list) 
	candidate_list	= input_list
	steps = 0
	while true
		candidate_list 	= redistribute(candidate_list)
		steps += 1
		#printf("%s\n",candidate_list)
		search_list = candidate_list.join(',')
		if $database.include? search_list
		 	break
		else
		 	$database.push(search_list)	
		end
	end
	return steps
end

if __FILE__ == $0

	input_l	= parse_input()
	test_array = [0, 2, 7, 0]
	#initialize database
	$database.push(input_l.join(','))

	assert count_interations(test_array) == 5, "[-] Test failed."
	puts count_interations(input_l)
end
