# https://adventofcode.com/2021/day/9

def load (day: ,is_test: false)
  sample = is_test ? "-sample" : ""
  file_path = File.expand_path("../day-#{day}#{sample}.txt", __FILE__)
  lines = File.readlines(file_path)  
  
  #format input
  lines.map {|line| line.strip.split(//).map(&:to_i)}
end

def get_adjacents(map, pos)
  adjacents = []  
  adjacents << [pos[0]-1,pos[1]]
  adjacents << [pos[0],pos[1]-1]
  adjacents << [pos[0],pos[1]+1]  
  adjacents << [pos[0]+1,pos[1]]  

  #puts adjacents.to_s

  #remove below zeroes
  adjacents = adjacents.select {|x| x[0] >=0 and x[1] >= 0 and x[0] <= map.size-1 and x[1] <= map[0].size-1 }


  #puts adjacents.to_s
  adjacents.map {|x| map[x[0]][x[1]]}
end

def process_part1
  data = load(day:"09", is_test: false)  

  #puts data.to_s
  #puts get_adjacents(data, [0,9]).to_s
  get_mins data
end

def get_mins (data)
  risk = 0
  mins = []
  puts "#{data.size}, #{data[0].size}"
  data.each_with_index do |row,r| 
    row.each_with_index do |col,c|       
      adj = get_adjacents(data, [r,c]).min
      if adj and col < adj
        #puts "#{r},#{c},#{col},#{adj}"
        mins << col
        risk += col + 1
      end
    end
  end  
  
  puts mins.to_s
  puts risk
end


def process_part2
  data = load(day:"08", is_test: false)  

end

def process
  process_part1
end