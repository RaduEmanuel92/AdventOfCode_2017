#!/usr/bin/env ruby

def process_line(line)
	return line.split(" ").map{|x| x.chomp}.reject{|c| c == "\n"}
end

def detect_dup(list)
	return false if list.detect{ |x| list.count(x) > 1 }
  	return true	
end

def parse_file
	nr_pass = 0
	File.open("input", 'r').each do |line|
		candidate_pass = process_line(line)
		candidate_pass.map!  {|x| x.split('').sort.join('')} 
		if detect_dup(candidate_pass)
			printf("[+] Good pass: %s\n", candidate_pass)
			nr_pass += 1
		end
	end
	return nr_pass		
end

if __FILE__ == $0
	puts parse_file
end