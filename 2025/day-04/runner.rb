def load(is_test = true)
  file_path = File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__)

  File.readlines(file_path)
end

def process_part1(_input)
  puts 'im here'
end

def process_part2(input); end

def process
  input = load(false)
  process_part1(input)
end
