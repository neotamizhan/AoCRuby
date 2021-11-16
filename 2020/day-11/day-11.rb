# https://adventofcode.com/2020/day/11

class Seat
  attr_accessor :row, :col, :seat_num, :state, :adjecents

  def seat_num
    "#{row}-#{col}"
  end
end



def process
  seats = []
  file_path = File.expand_path("../day-11.txt", __FILE__)
  puts file_path
  File.readlines(file_path).each do |line,row|
    line.chars.each do |c,col|
      seat = Seat.new 
      puts "#{c} - #{row} - #{col}"
      seat.row = row
      seat.col = col
      seat.state = c
      seats << seat
      #puts seat.seat_num
    end
  end
  
end

