
def load_test
  file_path = File.expand_path("../day-12-sample.txt", __FILE__)
  File.readlines(file_path).map(&:to_i)
end

def load
  file_path = File.expand_path("../day-12.txt", __FILE__)
  File.readlines(file_path).map(&:to_i)
end

def process_part1
  depths = load
  deeper = 0
  (0..depths.size).each { |i| deeper += 1 if i > 0 and depths[i] and depths[i] > depths[i-1] }  

  puts deeper
end


def process_part2
  depths = load
  deeper = 0
  
  (0..depths.size).each do |i| 
    deeper += 1 if depths[i+1] and depths[i+2] and depths[i] + depths[i+1] + depths[i+2] >  depths[i-1] + depths[i] + depths[i+1] 
  end  
  
  puts deeper
end

def process
  process_part1
end