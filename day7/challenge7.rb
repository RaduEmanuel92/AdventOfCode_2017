4#!/usr/bin/env ruby
require "solid_assert"

$process_list = []

def process_line(line)
	return line.split(' ').map { |x| x.chomp("/n")}.
							reject { |x| x == "->" }.
							map { |x| x.chomp(",")}.
							map { |x| x.tr("()", '')}
end

def parse_file(file)
	f = file
	File.open(f, "r").each do  |line|  
		line = process_line(line).to_a
		#printf("%s\n", line)
		$process_list.push(line)
	end
end

def find_bottom(proc)
	temp = $process_list.find_all{ |x| x.include?(proc[0])}
	if (temp.length > 1) 
		if (temp[0][0] != proc[0]) 
			find_bottom(temp[0])
		else 
			find_bottom(temp[1])
		end
	else
		return temp[0][0]
	end
end

def stack_weight(proc)
	temp = $process_list.find{ |x| x[0] == proc}
	sum_layer = []
	parse = temp[2..(temp.length-1)]
		for index in parse
			sum =  find_weight(index)
			sum_layer.push(sum)	
		end	
	return temp[1], sum_layer.sum
end

def find_weight(proc)
	temp = $process_list.find{ |x| x[0] == proc}
	sum = temp[1].to_i
	#printf("node_s : %s\n", sum)
	if temp.length > 2	
		parse = temp[2..(temp.length-1)]
		#printf("parse : %s\n", parse)
		for index in parse
			sum += find_weight(index)	
		end
		return sum
	else	
		return sum 
	end
end

def compute_layers
	min = 100000000000
	issue_layer = []
	found_layer = []
	$process_list.each do |x|	
		temp = x
		sum_layer = []
		if temp.length > 2			
			parse = temp[2..(temp.length-1)]
			for index in parse
				sum =  find_weight(index)
				sum_layer.push(sum)	
			end
		if ( sum_layer.uniq.length == 2)
			if  min > sum_layer[1]
				min = sum_layer[1]
				issue_layer = sum_layer
				found_layer = temp
			end		
		end	
		sum_layer = []
		end
	end
	printf("%s \n", issue_layer)
	return found_layer
end

if __FILE__ == $0
	#test
	parse_file("input_test")
	answer = find_bottom($process_list[0])
	printf("[+] Answer: %s\n", answer == 'tknk')

	#task1
	$process_list = []
	parse_file("input")
	answer =  find_bottom($process_list[0])
	printf("[+] Answer: %s\n", answer)

	#task2
 	wid = compute_layers
 	printf("Problem layer: %s\n", wid)
 	printf("%s\n", stack_weight(wid[2]))
 	printf("%s\n", stack_weight(wid[3]))
 	printf("%s\n", stack_weight(wid[4]))
end
