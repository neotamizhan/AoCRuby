# https://adventofcode.com/2021/day/10

def load (day: ,is_test: false)
  sample = is_test ? "-sample" : ""
  file_path = File.expand_path("../day-#{day}#{sample}.txt", __FILE__)
  lines = File.readlines(file_path)  
  
  #format input
  lines = lines.map {|line| line.strip.split(//).map(&:to_i)}
  puts lines.to_s
  octomap = Hash.new
  lines.each_with_index {|row,r| row.each_with_index {|col,c| octomap[[r,c]] = col }}

  octomap
end

def incr_neighbors(data, elem)
  (elem[0]-1..elem[0]+1).each do |r|
    (elem[1]-1..elem[1]+1).each do |c|
      data[[r,c]] = data[[r,c]] + 1 if data[[r,c]]   
    end
  end

  data
end

def round(data)
  puts 
  puts data.to_s
  # increase all by 1
  data.each_pair {|k,v| data[k] = v + 1}

  #for each e = 10, increment all surrounding energies 
  tens = data.select {|k,v| v == 10}  
  tens.each_key do |k| 
    data = incr_neighbors(data, k)
  end

  #convert all 10s to 0
  flashes = data.select {|k,v| v > 9}.keys 
  flashes.each {|k| data[k] = 0}
  puts "------------"
  puts data.to_s
  
  puts "total flashes = #{flashes.size}"
  puts "***********"
  data
end

def process_part1
  data = load(day:"11", is_test: true)      
  3.times {|i| puts i; round(data)}
end

def process_part2
  data = load(day:"10", is_test: true)  

end

def process
  process_part1
end