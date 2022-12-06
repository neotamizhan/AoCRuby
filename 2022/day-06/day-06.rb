def get_marker(line, len)
  start = 0; has_marker = false
  until has_marker do
    has_marker = isSOP?(line[start..start+len-1])
    start = start + 1 unless has_marker
  end
  
  start+len
end

#is packet start?
def isSOP?(str)  
  str.size == str.split('').uniq.size
end

def load (is_test: true)      
  file_path =  File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__) 
  line = File.read(file_path)  
end


def process_part1
  puts get_marker(load(is_test: false), 4)  
end


def process_part2  
  puts get_marker(load(is_test: false), 14)  
end

def process
  process_part2
end