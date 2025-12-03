def load(is_test = true)
  file_path = File.expand_path("../day-01#{is_test ? '-sample' : ''}.txt", __FILE__)

  File.readlines(file_path)
end

def process_part1(lines, mode)
  dial = 50
  pwd = 0
  lines.each do |line|
    command = get_command(line, mode)
    puts command
    if command[:direction] == 'L'
      dial = (dial - command[:steps]) % 100
    else
      dial = (dial + command[:steps]) % 100
    end 
    puts dial
    pwd += 1 if dial == 0
  end
  pwd
end


def get_command(line, mode)  
  #given L30, return L and 30 and return as a struct
  res = line.match(/([LR])(\d+)/)
  return {direction: res[1], steps: res[2].to_i}
end

def process_part2(lines, mode)
  dial = 50
  pwd = 0
  lines.each do |line|
    command = get_command(line, mode)
    puts command
    command[:steps].times do
      if command[:direction] == 'L'
        dial = (dial - 1) % 100
      else
        dial = (dial + 1) % 100
      end
      pwd += 1 if dial == 0
    end
    puts dial
  end
  pwd
end

def process
  lines = load(false)
  puts process_part2(lines, mode = 2)
end
