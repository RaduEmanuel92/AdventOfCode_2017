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
	#initialize database
	$database	= []
	steps		= 0
	$database.push(input_list.join(',')) 
	candidate_list	= input_list

	#counter
	while true
		candidate_list	= redistribute(candidate_list)
		steps	+= 1
		search_string	= candidate_list.join(',')
		if $database.include? search_string
		 	break
		else
		 	$database.push(search_string)	
		end
	end
	return steps, search_string.split(',').map(&:to_i)
end

if __FILE__ == $0

	input_l		= parse_input()
	test_array 	= [0, 2, 7, 0]
	assert count_interations(test_array) == 5, "[-] Test failed."
	
	result 	= count_interations(input_l)
	counter = result[0]
	found_config = result[1]

	printf("[+] Loop detected after %s cycles. \n", counter)
	printf("[+] Size of loop: %s\n", count_interations(found_config)[0])
end
