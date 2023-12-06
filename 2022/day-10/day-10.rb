def processor(lines)
  x = 1; cycle = 0; signal_strength = []
  intercept = [20,60,100,140,180,220]

  (0..lines.size-1).each do |i|
    line = lines[i]    
    cmd, val = line ? line.chomp.split(' ') : ['',0]
    cycle = cycle + 1    
    if cycle == intercept[0]      
      signal_strength << cycle * x 
      intercept = intercept.drop(1)
    end    
    next if cmd.include? "noop"

    if cmd.include? "addx" 
      cycle = cycle + 1
      if cycle == intercept[0]
        signal_strength << cycle * x 
        intercept = intercept.drop(1)
      end
      x = x + val.to_i
    end                          
  end

  signal_strength.reduce(&:+)
end

def load (is_test: true)      
  file_path =  File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__) 
  lines = File.readlines(file_path)  

  puts processor(lines).to_s
end


def process_part1
  load(is_test: false)
end


def process_part2  
  load(is_test: false)
end

def process
  process_part1
end