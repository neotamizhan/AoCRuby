# https://adventofcode.com/2021/day/10

def load (day: ,is_test: false)
  sample = is_test ? "-sample" : ""
  file_path = File.expand_path("../day-#{day}#{sample}.txt", __FILE__)
  lines = File.read(file_path)  
  
  #format input
  lines
end

def h2b(data)
  [data].pack('H*').unpack('B*').first  
end

def b2d(data)
  data.join.to_i(2)
end

def parse(data)
  packet = Hash.new
  puts data.join
  packet[:v] = b2d(data.shift(3))
  puts data.join
  packet[:t] = b2d(data.shift(3))
  puts data.join
  packet[:lt] = b2d(data.shift(1))
  puts data.join
  case packet[:lt]
  when 0
    packet[:packet_length] = b2d(data.shift(11)) 

  when 1
    packet[:packet_count] = b2d(data.shift(11))
    contents = []
    packet[:packet_count].times do
      contents << b2d(data.shift(11))
    end
    packet[:contents] = contents    
  end
  puts data.join
  [packet, data]
end

def process_part1
  data = load(day:"16", is_test: true)      
  bindata = h2b(data).split(//)
  puts bindata.join  
  packets = []
  while data.length > 1  
    puts "Calling Parse"
    result = parse(bindata)
    packets << result[0]
    data = result[1]
  end  

  puts packets.to_s
end

def process_part2
  data = load(day:"10", is_test: true)    
end

def process
  process_part1
  #puts "10101000000".to_i(2)
end