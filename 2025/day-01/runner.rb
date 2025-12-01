def load(is_test = true)
  file_path = File.expand_path("../day-01#{is_test ? '-sample' : ''}.txt", __FILE__)

  File.readlines(file_path)
end

def process_part1(lines, mode)
  dial = 50
  pwd = 0
  lines.each do |line|
    command = get_command(line, mode)
    if command[:direction] == 'L'
      dial -= command[:steps]
      dial = 100 + dial if dial < 0
    else
      dial += command[:steps]
      dial = 100 - dial if dial > 100
    end
    pwd += 1 if dial == 0
  end
  pwd
end


def get_command(line, mode)  
  #given L30, return L and 30 and return as a struct
  res = line.match(/([LR])(\d+)/)
  return {direction: res[1], steps: res[2].to_i}
end

def process_part2(_lines)
  process_part1(new_lines)
end

def process
  lines = load(true)
  puts process_part1(lines, mode = 2)
end
