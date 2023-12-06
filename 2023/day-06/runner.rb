def load(is_test = true)
  file_path = File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__)

  File.readlines(file_path)
end

def process_part1(input)
  times = input[0].split(' ').map(&:to_i)
  distances = input[1].split(' ').map(&:to_i)
  chances = []
  
  times.each_with_index do |t,idx| 
    puts "#{t}"
    chances << (0..t).map {|i| i * (t-i)}.filter {|j| j > distances[idx]}.size
  end
  puts chances.reduce(&:*)
end

def process_part2(input)
  times = input[0].gsub(' ','').to_i
  distances = input[1].gsub(' ','').to_i
  chances = []    
  chances << (0..times).map {|i| i * (times-i)}.filter {|j| j > distances}.size
  
  puts chances.reduce(&:*)
end

def process
  input = load(false)
  process_part2(input)
end
