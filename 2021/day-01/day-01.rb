def load
  file_path = File.expand_path("../day-01.txt", __FILE__)
  lines = File.readlines(file_path)
  depths = lines.map(&:to_i)

  depths
end

def process_part1
  depths = load
  deeper = 0
  depths.each_with_index do |v,i|
    next if i==0 
    deeper = deeper + 1 if depths[i] > depths[i-1]
  end

  puts deeper
end


def process
  depths = load
  deeper = 0
  sliding_sum = []
  depths.each_with_index do |v,i|
    sliding_sum << depths[i] + depths[i+1] + depths[i+2] if depths[i+2]
  end

  sliding_sum.each_with_index do |v,i|
    next if i==0 
    deeper = deeper + 1 if sliding_sum[i] > sliding_sum[i-1]
  end
  
  puts deeper
end