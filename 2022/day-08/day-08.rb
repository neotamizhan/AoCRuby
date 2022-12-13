def processor(lines)
  trees = Array.new(lines.size){Array.new(lines[0].length)}
  lines.each_with_index do |line, index|
    trees[index] = line.chomp.split(//)
  end  

  #get_visible_trees(trees)
  get_scenic_scores(trees)
end

def get_visible_trees(trees)
  visible = 0
  rows = trees.size-1
  cols = trees[0].size-1 
  (0..rows).each do |row|
    (0..cols).each do |col|
      visible = visible + 1 if visible?(trees, row, col)     
    end
  end

  visible
end

def get_scenic_scores(trees)
  scenic = []
  rows = trees.size-1
  cols = trees[0].size-1 
  (0..rows).each do |row|
    (0..cols).each do |col|
      scenic << scenic(trees, row, col)     
    end
  end

  scenic
end

def edge? (trees, row, col)
  (row == 0 or row == trees.size-1 ) or (col == 0 or col == trees[0].size-1)
end

def visible? (trees, row, col)
  return true if edge?(trees, row, col)

  left = right = up = down = true
  val = trees[row][col]
  (0..col-1).each {|i| left = left && (trees[row][i] < val)}
  (col+1..trees[0].size-1).each {|i| right = right && (trees[row][i] < val)}
  (0..row-1).each {|i| up = up && (trees[i][col] < val)}
  (row+1..trees.size-1).each {|i| down = down && (trees[i][col] < val)}
  
  #puts "left:  #{row}:#{col}:#{val}:#{left}"
  #puts "right: #{row}:#{col}:#{val}:#{right}"
  #puts "up:    #{row}:#{col}:#{val}:#{up}"
  #puts "down:  #{row}:#{col}:#{val}:#{down}"
  
  left || right || up || down
end

def scenic (trees, row, col)  

  return -1 if edge?(trees, row, col)
  left = right = up = down = scenic = 0
  
  val = trees[row][col]

  (col-1).downto(0).each do |i| 
    #puts i
    left = left + 1  
    break if trees[row][i] >= val
  end

  (col+1..trees[0].size-1).each do |i| 
    right = right + 1 
    break if trees[row][i] >= val
  end

  (row-1).downto(0).each {|i| up = up + 1; break if trees[i][col] >= val}
  (row+1..trees.size-1).each {|i| down = down + 1; break if trees[i][col] >= val}
  
  #puts "left:  #{row}:#{col}:#{val}:#{left}"
  #puts "right: #{row}:#{col}:#{val}:#{right}"
  #puts "up:    #{row}:#{col}:#{val}:#{up}"
  #puts "down:  #{row}:#{col}:#{val}:#{down}"
  
  left * right * up * down
end

def load (is_test: true)      
  file_path =  File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__) 
  lines = File.readlines(file_path)  

  puts processor(lines).max
end


def process_part1
  load(is_test: false)
end


def process_part2  
  load(is_test: false)
end

def process
  process_part2
end