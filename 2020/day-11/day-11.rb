# https://adventofcode.com/2020/day/11

class Seat
  attr_accessor :row, :col, :seat_num, :state, :adjecents

  def seat_num
    "#{row}-#{col}"
  end

  def fill_adjecents (seats)
    @adjecents = []
    @adjecents << seats.select {|s| s.row == @row - 1 and s.col == @col - 1}.first
    @adjecents << seats.select {|s| s.row == @row - 1 and s.col == @col}.first
    @adjecents << seats.select {|s| s.row == @row - 1 and s.col == @col + 1}.first
    @adjecents << seats.select {|s| s.row == @row and s.col == @col - 1}.first
    @adjecents << seats.select {|s| s.row == @row and s.col == @col + 1}.first
    @adjecents << seats.select {|s| s.row == @row + 1 and s.col == @col - 1}.first
    @adjecents << seats.select {|s| s.row == @row + 1 and s.col == @col}.first
    @adjecents << seats.select {|s| s.row == @row + 1 and s.col == @col + 1}.first      
  end


  def change_state! (seats)    
    fill_adjecents(seats)
    occupied = @adjecents.select {|a| a and a.state == '#'}.length

     case @state
      when 'L'
        @state = '#' if occupied == 0    
      when '#'
        @state = 'L' if occupied >= 4      
    end
  end
end

class Room
  attr_accessor :seats  

  @@vals = [".","L","#"]

  def fill_seats!        
    file_path = File.expand_path("../day-11.txt", __FILE__)
    lines = File.readlines(file_path)
    puts lines[0].to_s
    @seats = Array.new(lines.length) {Array.new(lines[0].length-1){'.'}}

    lines.each_with_index do |line,row|
      line.chars.each_with_index do |c,col|
        @seats[row][col] = c if @@vals.include?(c)
      end
    end 
    
    puts @seats[0].to_s
  end

  def get_occupied(row, col)
    current_state = @seats[row][col]
    occupied = 0
    (row-1..row+1).each do |nr|
      (col-1..col+1).each do |nc|
        next if (row == nr ) and (col == nc)
        occupied+= 1 if @seats[nr] and @seats[nr][nc] and @seats[nr][nc] == '#'
      end
    end
    #puts "(#{row} , #{col})=#{occupied}"
    occupied
  end

  def get_total_occupied
    @seats.map {|r| r.select {|s| s == '#' or s == '.'}.length}.reduce(:+)
  end

  def run_thru! 
    all_occupied = get_all_occupied   
    @seats.each_with_index do |row, rownum|
      row.each_with_index do |col, colnum|
        occupied = all_occupied[rownum][colnum]
        new_status = @seats[rownum][colnum]
        case @seats[rownum][colnum]
          when 'L'
            new_status = '#' if occupied == 0    
          when '#'
            new_status = 'L' if occupied >= 4      
          else 
            new_status = @seats[rownum][colnum]
        end
        @seats[rownum][colnum] = new_status
      end
    end
  end

  def get_room_hash
    room_hash = 0
    @seats.each_with_index do |r, rn| 
      r.each_with_index do |s,sn| 
        room_hash += rn * sn * @@vals.index(s)+1
      end
    end

    room_hash
  end

  def get_all_occupied
    occupied = Array.new(@seats.length) {Array.new(@seats[0].length){0}}
    @seats.each_with_index do |r, rn| 
      r.each_with_index do |s,sn| 
        occupied[rn][sn] = get_occupied(rn,sn)
      end
    end

    occupied
  end
end

def process
  room = Room.new
  room.fill_seats!
  puts room.seats.to_s
  old_hash = new_hash = 0

  loop do 
    puts 'Iterating...'
    old_hash = room.get_room_hash
    room.run_thru!
    puts room.seats.to_s
    new_hash = room.get_room_hash

    puts "#{old_hash} - #{new_hash}"
    break if old_hash == new_hash
  end
  

  puts room.seats.to_s

  puts room.get_total_occupied
end