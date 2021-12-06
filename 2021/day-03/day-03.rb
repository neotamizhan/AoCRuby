def load (day: ,is_test: false)
  sample = is_test ? "-sample" : ""
  file_path = File.expand_path("../day-#{day}#{sample}.txt", __FILE__)
  lines = File.readlines(file_path)
  
  #format input
  lines.map {|x|x.strip().split(//)}
end

def get_freq(arr, pos, most)
  z = o = 0
  arr.each {|x| x[pos].to_i == 0 ? z += 1 : o += 1}
  if (z==o)
    freq = most ? [1,0] : [0,1]
  else 
    freq = (o > z) ? [1,0] : [0,1]  
  end 

  #puts "#{arr.size}, #{pos}, (#{z},#{o}) , #{freq.to_s}"
  freq
end

def process_part1
  arr = load(day:"03", is_test: false)
  new_a = arr.transpose()
  gamma_arr = new_a.map {|x| x.count("0") > x.count("1") ? "0" : "1"}
  epsilon_arr = new_a.map {|x| x.count("0") > x.count("1") ? "1" : "0"}

  puts gamma_arr.join.to_i(2) * epsilon_arr.join.to_i(2)
end


def process_part2
  arr = load(day:"03", is_test: false)  
  i = 0
  
  oxy = arr.clone
  co2 = arr.clone

  while oxy.size > 1 do
    g = get_freq(oxy,i,most: true)[0]
    oxy = oxy.select {|x| x[i].to_i == g}
    i += 1
  end

  puts oxy.join.to_i(2)
  i=0
  while co2.size > 1 do
    g = get_freq(co2,i,most: false)[1]
    co2 = co2.select {|x| x[i].to_i == g}
    i += 1
  end  

  puts co2.join.to_i(2)

  puts oxy.join.to_i(2) * co2.join.to_i(2)
end

def process
  process_part2
end