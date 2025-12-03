def load(is_test = true)
  file_path = File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__)

  File.readlines(file_path)
end

#take input and return array of arrays
def parse_input(input)
  output = []
  input = input.map(&:chomp)
  input.map do |line|
    line.split(',').each do |range|
      #range.split('-').map(&:to_i)
      #puts range
      range = range.split('-').map(&:to_i)
      output << (range[0]..range[1])
    end
  end
  output
end

#remove any number that is repeated in the range
def filter_repeats(range)
  ary = range.to_a
  #puts ary
  ary.select do |num| 
    num = num.to_s
    num.length.even? && num[0..num.length/2-1] == num[num.length/2..num.length]
  end
end 

def process_part1(_input)
  parsed_input = parse_input(_input)
  #puts "#{parsed_input}"
  puts parsed_input.map { |range| filter_repeats(range).sum}.to_a.sum
end

# Check if number is made of a sequence repeated at least twice
def is_repeated_sequence?(num)
  s = num.to_s
  (1..s.length / 2).each do |len|
    next unless s.length % len == 0
    
    substring = s[0, len]
    expected = substring * (s.length / len)
    return true if s == expected
  end
  false
end

def process_part2(_input)
  parsed_input = parse_input(_input)
  puts parsed_input.map { |range| 
    range.select { |num| is_repeated_sequence?(num) }.sum 
  }.sum
end

def process
  input = load(false)
  process_part2(input)
end
