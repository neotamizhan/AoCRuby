class Elf
  def initialize (lines)
    @food = lines.split("\n").map(&:to_i)
  end

  def calories
    @food.reduce(&:+)
  end
end

def load (is_test = true)  
  elves = Array.new
  
  file_path =  File.expand_path("../day-01#{is_test ? '-sample' : ''}.txt", __FILE__) 
  food_items = File.read(file_path).split("\n\n")
  food_items.each  {|lines| elves << Elf.new(lines)}

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