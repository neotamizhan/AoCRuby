def load (day: ,is_test: false)
  sample = is_test ? "-sample" : ""
  file_path = File.expand_path("../day-#{day}#{sample}.txt", __FILE__)
  lines = File.read(file_path)  
  
  #format input
  lines.split(',').map(&:to_i)
end

def calc(pos)
  vals = pos.uniq.sort
  cost = Hash.new()
  vals.each {|v| cost[v] = pos.map {|p| (p-v).abs}.reduce(:+)}   
  cost
end

def smart_calc(pos)
  vals = (pos.min..pos.max).to_a
  cost = Hash.new()
  vals.each {|v| cost[v] = pos.map {|p| n = (p-v).abs; (n*(n+1))/2}.reduce(:+)}   
  cost
end


def process_part1
  data = load(day:"07", is_test: false)  
  costs = calc(data)  
  puts costs.values.min
end


def process_part2
  data = load(day:"07", is_test: false)  
  costs = smart_calc(data)
  puts costs.values.min  
end

def process
  process_part2
end