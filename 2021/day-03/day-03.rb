def load (day: ,is_test: false)
  sample = is_test ? "-sample" : ""
  file_path = File.expand_path("../day-#{day}#{sample}.txt", __FILE__)
  lines = File.readlines(file_path)
  
  lines.map {|x|x.split(' ')}
end

def process_part1

end


def process_part2

end

def process
  process_part1
end