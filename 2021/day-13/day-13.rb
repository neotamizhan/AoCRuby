def load (is_test = true)    
  dots = {}  
  folds = []
  file_path =  File.expand_path("../day-13#{is_test ? '-sample' : ''}.txt", __FILE__) 
  lines = File.readlines(file_path)
  while lines do |line|
    line.contains("fold")
  end
  lines.each  {|lines| elves << Elf.new(lines)}

  elves
end

def process_part1
  elves = load (false)
  elves.max_by {|elf| elf.calories}.calories
end


def process_part2  
  elves = load (false)
  elves.sort_by {|elf| elf.calories}.pop(3).map {|e| e.calories}.reduce(&:+)
end

def process
  puts process_part2
end