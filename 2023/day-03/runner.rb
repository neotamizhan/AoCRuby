def load(is_test = true)
  file_path = File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__)

  File.readlines(file_path)
end

def process_part1(input)
  puts get_all_parts(input).reduce(&:+)
end

def process_part2(input)
  puts get_gear_ratios(input).to_s
end

def get_matrix(input)
  matrix = []
  input.each_with_index do |line, row|
    line.strip!
    num = ''
    row_arr = []
    puts line.strip.split(//).to_s if row == 14
    line.split(//).each_with_index do |char, c|  
      puts "char: #{char}, c: #{c}, line len: #{line.length}" if row == 14 and c == 139
      if /\d/.match(char)
        num += char
        if c == line.length - 1
          puts "in here"
          row_arr << [row, (c - num.size..c).to_a, num] 
          num = ''        
        end
      else
        if num.size > 0
          row_arr << [row, (c - num.size..c - 1).to_a, num]
          num = ''
        end
        row_arr << [row, [c], char] if char != '.'
      end
    end
    matrix[row] = row_arr
  end
  matrix
end

def get_all_symbols(matrix)
  symbols = []
  matrix.each_with_index do |row, _r|
    row.each_with_index do |col, _c|
      symbols << col unless /[0-9]/.match(col[2])
    end
  end
  symbols
end

def get_all_asterix(matrix)
  asterix = []
  matrix.each_with_index do |row, _r|
    row.each_with_index do |col, _c|
      asterix << col if col[2] == "*"
    end
  end
  asterix
end

def get_all_parts(input)
  gears = {}
  matrix = get_matrix(input)
  symbols = get_all_symbols(matrix)
  # puts symbols.to_s
  #puts matrix.to_s
  symbols.each do |symbol|
    symrow = symbol[0]
    symcol = symbol[1][0]
    range = [symrow - 1, symrow, symrow + 1]
    range.each do |row|
      # next if (row == -1) || (row == matrix.size)

      matrix[row].each do |col|
        if ([symcol - 1, symcol, symcol + 1].intersection(col[1]).size > 0) && /[0-9]/.match(col[2])
          #puts "#{row}, #{col[1]}, #{col[2]}"
          #parts << col[2].to_i
          gears[symbol] << col[2].to_i
        end
      end
    end
  end
  # puts "***********"
  # puts parts
  # puts "***********"
  gears
end

def get_gear_ratios(input)
  gears = {}
  matrix = get_matrix(input)
  asterix = get_all_asterix(matrix)

  asterix.each do |symbol|
    gears[symbol] = []
    symrow = symbol[0]
    symcol = symbol[1][0]
    range = [symrow - 1, symrow, symrow + 1]
    range.each do |row|
      # next if (row == -1) || (row == matrix.size)

      matrix[row].each do |col|
        if ([symcol - 1, symcol, symcol + 1].intersection(col[1]).size > 0) && /[0-9]/.match(col[2])
          #puts "#{row}, #{col[1]}, #{col[2]}"
          #parts << col[2].to_i
          gears[symbol] << col[2].to_i
        end
      end
    end
  end
  gears.values.filter { |v| v.size == 2 }.map { |v| v.reduce(&:*) }.reduce(&:+)  
end

def process
  input = load(false)
  process_part2(input)
end
