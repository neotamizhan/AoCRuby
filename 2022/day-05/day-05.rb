class Crates
  
  attr_accessor :moves, :stacks
  
  def initialize (lines, multi_move_crane)
    @moves = []     
    @stacks = {}
    @multi_move_crane = multi_move_crane
    lines.each do |line|      
      case 
        when line.include?("move")
          vals = line.split(' ')
          @moves << {count: vals[1].to_i, from: vals[3].to_i, to: vals[5].to_i}    
        
        when line.include?("[")
          stack = []
          line.scan(/(.{3})[ \r\n]/).flatten.each_with_index do |v,i|         
            @stacks[i] = [] unless @stacks.has_key? (i) #init array first time
            @stacks[i].unshift v unless v.strip.empty?            
          end
      end
    end    
  end

  def do_all_moves
    @moves.each {|m| move(m)}
  end
  
  def move(instr)
    if @multi_move_crane then 
        @stacks[instr[:to]-1].push(@stacks[instr[:from]-1].pop(instr[:count])).flatten!
    else
      instr[:count].times {@stacks[instr[:to]-1].push(@stacks[instr[:from]-1].pop)}
    end
  end

  def get_top_crates
    @stacks.values.map {|l| l[-1]}.join.gsub(/[\[\]]/,'')
  end
end

def load (is_test: true, multi_move_crane: false)      
  file_path =  File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__) 
  lines = File.readlines(file_path)
  
  crates = Crates.new(lines, multi_move_crane)
  crates.do_all_moves
  
  puts crates.get_top_crates
end


def process_part1
  load
end


def process_part2  
  load(is_test: false, multi_move_crane: true)
end

def process
  process_part2
end