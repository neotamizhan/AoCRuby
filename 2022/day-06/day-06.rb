def load (is_test: true)      
  file_path =  File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__) 
  lines = File.readlines(file_path)

end


def process_part1
  load
end


def process_part2  
  
end

def process
  process_part1
end