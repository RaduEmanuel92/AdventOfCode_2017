#!/usr/bin/env ruby
require "test/unit/assertions"

$vars = Hash.new

def process_line(line)
	return line.split('if').map {|x| x.chomp("\n")}.map {|x| x.split(' ')}						   
end

def test_existence(value)
	if !$vars.has_key?(value)
		$vars.store(value, 0)
	end
end

def replace(char)
	if char == 'dec'
		return '-'
	end
	return '+'
end

def test_condition(list)
	test_existence(list[0])
	list[0] = "\$vars[\"#{list[0].to_s}\"]"
	return eval(list.join())
end

def operation(list)
	test_existence(list[0])
	list[0] = "\$vars[\"#{list[0].to_s}\"]=\$vars[\"#{list[0].to_s}\"]"
	list[1] = replace(list[1])
	return eval(list.join())
end

def largest_key(hash)
	hash.max_by{|k,v| v}
end

def solver(file)
	max_val = 0
	File.open(file, "r").each do |line|
		instruction =  process_line(line) 
		if test_condition(instruction[1])
			operation(instruction[0])
			if  max_val < largest_key($vars)[1]
				max_val = largest_key($vars)[1]
			end
		end
	end
	return max_val		
end 

if __FILE__ == $0
	puts solver("input")
	puts $vars
	puts largest_key($vars)
end
 