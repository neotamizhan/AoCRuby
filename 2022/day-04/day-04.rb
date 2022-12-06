def load(is_test = true)
  pairs = []
  file_path = File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__)
  
  File.readlines(file_path).map {|line| line.strip.split(",")}.each do |a,b|    
   pairs << [(a.split("-")[0]..a.split("-")[1]).to_a, (b.split("-")[0]..b.split("-")[1]).to_a]    
  end

  pairs
end

def process_part1
  puts load(false).map {|e| (e[0] - e[1]).empty? or (e[1] - e[0]).empty?}.count(true)
end

def process_part2
  puts load(false).map {|e| e[0].intersection(e[1]).size > 0}.count(true)
end

def process
  process_part2
end
