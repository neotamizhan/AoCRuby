def load(is_test = true)
  file_path = File.expand_path("../day-01#{is_test ? '-sample' : ''}.txt", __FILE__)

  File.readlines(file_path)
end

def process_part1(lines, mode)
  puts lines.map { |l| get_num(l,2)}.reduce(:+)
end

def text2num(line)
  rep_arr = { 'zero' => 0, 'one' => 1, 'two' => 2, 'three' => 3, 'four' => 4, 'five' => 5, 'six' => 6, 'seven' => 7, 'eight' => 8, 'nine' => 9 }
  nums = {}
  spos = 0; epos = 0

  #Grt all numbers into the hash
  line.split(//).each_with_index {|c,i| nums[i] = c.to_i if /\d/.match(c)}

  #hunt for the word nums
  rep_arr.each_key do |key|
    spos=0
    while spos < line.length
      spos = line.index(key, spos)
      if spos
        nums[spos] = rep_arr[key] 
        spos = spos + 1
      else
        break
      end
    end
  end

  #nums = nums.sort

  nums.sort.to_h.values.join('')
end

def get_num(line, mode)  
  if mode == 2 
    line = text2num(line) 
    #puts line
  else
    line.gsub!(/[a-z]/, '')
  end
  
  if line.nil?
    0
  else
    line.strip!
    (line[0] + line[-1]).to_i
  end
end

def process_part2(_lines)
  process_part1(new_lines)
end

def process
  lines = load(false)
  process_part1(lines, mode = 2)
end
