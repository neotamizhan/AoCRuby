def load (day: ,is_test: false)
  sample = is_test ? "-sample" : ""
  file_path = File.expand_path("../day-#{day}#{sample}.txt", __FILE__)
  File.readlines(file_path).map {|x|x.split(' ')}
end

def process_part1
  hor = deep = 0

  instructions = load(day: "02", is_test: false)

  instructions.each do |ins| 
    cmd = ins[0]
    dist = ins[1].to_i
    case cmd
      when "forward"
        hor += dist
      when "down"
        deep += dist
      when "up"
        deep -= dist
    end  
  end

  puts hor * deep
end


def process_part2
hor = deep = aim = 0

instructions = load(day: "02", is_test: false)

instructions.each do |ins| 
  cmd = ins[0]
  dist = ins[1].to_i
  case cmd
    when "forward"
      hor += dist
      deep += (aim * dist)
    when "down"
      aim += dist
    when "up"
      aim -= dist
  end   
end

puts hor * deep
end

def process
  process_part2
end