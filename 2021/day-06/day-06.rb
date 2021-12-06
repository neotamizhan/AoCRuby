def load (day: ,is_test: false)
  sample = is_test ? "-sample" : ""
  file_path = File.expand_path("../day-#{day}#{sample}.txt", __FILE__)
  lines = File.read(file_path)  
  
  #format input
  lines.split(',').map(&:to_i)
end

def grow(data)
  (0..data.size-1).each do |i|       
    if data[i] == 0  
      data << 8 
      data[i] = 6
    else
      data[i] -= 1  
    end
  end

  data
end

def smart_grow(freq)
  zeroes = freq[0]  #save the zeroes as it will be reset by  1s
  (0..7).each {|n| freq[n] = freq[n+1]} #move higher numbers to current numbers.
  freq[8] = 0 #set 8s to zero
  if zeroes > 0
    freq[8] = zeroes 
    freq[6] += zeroes 
  end

  freq
end

def process_part1
  data = load(day:"06", is_test: true)  
  puts data.size

  18.times do
    data = grow(data)  
  end

  puts data.size
end


def process_part2
  data = load(day:"06", is_test: false)      
  empty = {8=>0,7=>0,6=>0,5=>0,4=>0,3=>0,2=>0,1=>0,0=>0}
  freq= data.tally
  freq = empty.merge(freq)  

  256.times do
    freq = smart_grow(freq)  
  end

  puts freq.values.reduce(:+)
end

def process
  process_part2
end