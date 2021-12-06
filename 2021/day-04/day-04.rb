class Board
  attr_accessor :matrix, :won

  def initialize (lines)
    @matrix = Hash.new
    @wonrows = []
    @woncols = []

    lines.each_with_index do |line, row|
      line.each_with_index do |num, col|
        #puts "#{row},#{col},#{num}"
        @matrix[[row,col]] = (num == 0) ? [num,1] : [num,0] #number and mark flag        

      end
    end
  end
  
  def find_num (num)    
    @matrix.key([num,0]) ? @matrix.key([num,0]) : @matrix.key([num,1])
  end

  def mark! (num) 

    k = find_num(num)
    puts k if num == 13
    return false unless k

    puts "Key = #{k}"
    @matrix[k][1] = 1

    row = k[0]
    col = k[1]        

    rowsum = colsum = 0
    (0..4).each {|c| rowsum += @matrix[[row,c]][1]}
    (0..4).each {|r| colsum += @matrix[[r,col]][1]}
    
    @won = rowsum == 5 or colsum == 5

    @won
  end

  def score(n)    
    sum = @matrix.select {|k,v| v[1] == 0 }.values.map {|x| x[0]}.reduce(:+)
    puts "winning draw = #{n}, #{sum}"
    sum * n
  end
end

def load (day: ,is_test: false)
  sample = is_test ? "-sample" : ""
  file_path = File.expand_path("../day-#{day}#{sample}.txt", __FILE__)
  lines = File.read(file_path)
  
  #format input
  lines.split(/\n\n/).map {|x|x.split(/\n/)}
end

def process_part1
  boards = []
  data = load(day:"04", is_test: false)  
  draws = data.shift[0].split(',').map(&:to_i)  
  puts draws.to_s
  input = data.map {|b| b.map {|x| x.split(" ").map(&:to_i)}}

  boards = input.map {|b| Board.new(b)}

  puts boards.to_s

  draws.each do |d|
    boards.each do |b|
      next if b.won
      if b.mark!(d) 
        puts b.score(d)
        exit
      end
    end
  end

end


def process_part2
  boards = []
  wins = []
  data = load(day:"04", is_test: true)  
  draws = data.shift[0].split(',').map(&:to_i)  
  #puts draws.to_s
  input = data.map {|b| b.map {|x| x.split(" ").map(&:to_i)}}

  boards = input.map {|b| Board.new(b)}

  #puts boards.to_s

  draws.each do |d|
    puts "Draw : #{d}"
    boards.each do |b|
      next if b.won      
      if b.mark!(d) 
        wins << b.score(d)        
      end
    end
  end

  puts wins[-1]
end

def process
  process_part2
end