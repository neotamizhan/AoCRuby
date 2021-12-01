def load_test
  file_path = File.expand_path("../day-02-sample.txt", __FILE__)
  File.readlines(file_path).map(&:to_i)
end

def load
  file_path = File.expand_path("../day-02.txt", __FILE__)
  File.readlines(file_path).map(&:to_i)
end

def process_part1

end


def process_part2

end

def process
  process_part1
end