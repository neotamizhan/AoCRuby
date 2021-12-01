def load_test
  file_path = File.expand_path("../day-01-sample.txt", __FILE__)
  File.readlines(file_path).map(&:to_i)
end

def load
  file_path = File.expand_path("../day-01.txt", __FILE__)
  File.readlines(file_path).map(&:to_i)
end

def process_part1
  depths = load_test
  deeper = 0
  depths.each_with_index { |v,i| deeper += 1 if i > 0 and depths[i] > depths[i-1] }  

  puts deeper
end


def process_part2
  depths = load
  deeper = 0
  
  depths.each_with_index do |v,i| 
    deeper += 1 if depths[i+1] and depths[i+2] and depths[i] + depths[i+1] + depths[i+2] >  depths[i-1] + depths[i] + depths[i+1] 
  end  
  
  puts deeper
end

def process
  process_part2
end