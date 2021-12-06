def load (day: ,is_test: false)
  sample = is_test ? "-sample" : ""
  file_path = File.expand_path("../day-#{day}#{sample}.txt", __FILE__)
  lines = File.readlines(file_path)  
  
  #format input
  lines.map {|x| get_coordinates(x)}.select {|y| y}
end

def get_coordinates(line)
  is_line = false
  pattern = /(\d+),(\d+) -> (\d+),(\d+)/
  coeds = pattern.match(line.strip).captures.map(&:to_i)    
  
  x = [coeds[0],coeds[2]]
  y = [coeds[1],coeds[3]]

  is_line = x[0] == x[1] or y[0] == y[1]
  
  return nil unless  x[0] == x[1] or y[0] == y[1]  
  x.sort!
  y.sort!

  array = (x[0]..x[1]).to_a.product((y[0]..y[1]).to_a)

  return array if is_line

  return is_diagonal?(array) ? array : nil  
end

def is_diagonal?(array) 
  return false unless array

  (1..array.size-1).each do |i|
    puts "#{array[i-1][0].to_s},#{array[i][0].to_s} : #{array[i-1][1].to_s},#{array[i][1].to_s}"
    return false unless array[i-1][0] == array[i][0]-1 and array[i-1][1] == array[i][1]-1
  end

  true
end

def process_part1
  data = load(day:"05", is_test: true)  
  puts data.to_s

  puts data.flatten(1).tally.select {|k,v| v>=2}.count

end


def process_part2
  
end

def process
  process_part1
end