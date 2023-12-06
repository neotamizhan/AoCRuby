def load(is_test: true)

  file_path = File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__)
  lines = File.read(file_path).split("\n\n").map { |l| l.split("\n") }

end

def process_part1

end

def process_part2

end

def process

end
