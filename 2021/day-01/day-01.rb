def load
  file_path = File.expand_path("../day-01.txt", __FILE__)
  File.readlines(file_path).map(&:to_i)
end

def process_part1
  depths = load
  deeper = 0
  depths.each_with_index { |v,i| deeper += 1 if i > 0 and depths[i] > depths[i-1] }  

  puts deeper
end


def process
  depths = load
  deeper = 0
  sliding_sum = []
  depths.each_with_index { |v,i| sliding_sum << depths[i] + depths[i+1] + depths[i+2] if depths[i+2] }

  sliding_sum.each_with_index { |v,i| deeper += 1 if sliding_sum[i] > sliding_sum[i-1] }  
  
  puts deeper
end