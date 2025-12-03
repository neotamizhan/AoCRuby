def load(is_test = true)
  file_path = File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__)

  File.readlines(file_path)
end


def get_battery_nums(line)
  battery_nums = []
  line.length.times do |i|
    (i..line.length).each do |j|
      battery_nums << "#{line[i]}#{line[j+1]}".to_i if i < line.length
      #puts "#{i},#{j}=#{battery_nums[-1]}"
    end
  end
  #puts battery_nums
  battery_nums.uniq!.sort![-1]
end

def parse_input(input)
  input.map(&method(:get_battery_nums))
end

def process_part1(_input)
  parsed_input = parse_input(_input)
  puts parsed_input
  puts parsed_input.sum
end

def get_largest_subsequence(line, length)
  current_index = 0
  result = ""
  remaining_needed = length

  while remaining_needed > 0
    # Search range: from current_index to (total_length - remaining_needed)
    # We must leave enough characters to fill the remaining spots
    search_end = line.length - remaining_needed
    
    best_digit = -1
    best_index = -1

    (current_index..search_end).each do |i|
      digit = line[i].to_i
      if digit > best_digit
        best_digit = digit
        best_index = i
      end
      # Optimization: if we find a 9, we can't do better, so stop searching this position
      break if digit == 9
    end

    result += best_digit.to_s
    current_index = best_index + 1
    remaining_needed -= 1
  end
  result.to_i
end

def process_part2(input)
  puts input.map(&:chomp).map { |line| get_largest_subsequence(line, 12) }.sum
end

def process
  input = load(false)
  process_part2(input)
end
