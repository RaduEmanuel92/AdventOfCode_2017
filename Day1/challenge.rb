#!/usr/bin/env ruby

if __FILE__ == $0

	#read value from file
	value_from_file  = File.open("input", "r") {|f| f.read}

	#create iterator
	str_array = value_from_file.split("").reject{|c| c == "\n"}
	int_array = str_array.map(&:to_i)
	puts int_array


	#Parse the string
	_sum_ 	= 0
	_len_ 	= int_array.length - 1

	for index in 0.._len_
		if int_array[index] == int_array[index+1]
			_sum_ = _sum_ + int_array[index]
			#printf("Value found! %d \n", int_array[index])
		end	
	end	

	#Final check
	if int_array.first == int_array.last
		printf("Adding first element: %d\n", int_array.first)
		_sum_ = _sum_ + int_array.first
	end

	printf("Sum is %d \n", _sum_)
end

