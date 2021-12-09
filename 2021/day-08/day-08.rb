# https://adventofcode.com/2021/day/8

def load (day: ,is_test: false)
  sample = is_test ? "-sample" : ""
  file_path = File.expand_path("../day-#{day}#{sample}.txt", __FILE__)
  lines = File.readlines(file_path)  
  
  #format input
  lines.map {|line| line.strip.split(' | ').map {|x| x.split(' ')}}
end

def code_to_digits(digits, array)   
  array.map {|c| digits[c.split(//).sort.join]}
end

def get_mapping(pattern)
  mapping = Hash.new 
  ("a".."g").to_a.each {|x| mapping[x] = ""}

  # c and f
  one = pattern.select {|x| x.length == 2}[0]
  mapping["c"] = mapping["f"] = one

  # get d
  three = pattern.select {|x| x.length == 3}[0]
  mapping["a"] = three.delete(mapping["c"])

  # b and d
  four = pattern.select {|x| x.length == 4}[0]
  mapping["b"] = mapping["d"] = four.delete(mapping["c"])

  # e and g
  seven = pattern.select {|x| x.length == 7}[0]
  mapping["e"] = mapping["g"] = seven.delete(mapping["a"]).delete(mapping["c"]).delete(mapping["b"])
  
  # get d and g using Number 3: 
  #Take 5 digit seq with "a" (b) and all of "c" and "f"
  num3 = pattern.select {|x| x.length == 5 and x.include? mapping["c"][0] and x.include? mapping["c"][1] }[0]
  
  #remove a and c from num3
  num3 = num3.delete(mapping["a"]).delete(mapping["c"])

  # find d 
  mapping["d"] = (num3.split('') & mapping["d"].split('')).join

  #find g
  mapping["g"] = (num3.split('') & mapping["g"].split('')).join

  #find b and e
  mapping["b"] = mapping["b"].delete(mapping["d"])
  mapping["e"] = mapping["e"].delete(mapping["g"])

  # get c and f using number 2
  num2 = pattern.select {|x| x.length == 5 and x.include? mapping["a"] and x.include? mapping["d"] and x.include? mapping["e"] and x.include? mapping["g"]}[0]
  
  num2 = num2.delete(mapping["a"]).delete(mapping["d"]).delete(mapping["e"]).delete(mapping["g"])
  
  mapping["c"] = num2
  mapping["f"] = mapping["f"].delete(mapping["c"])
  
  mapping
end

def get_correct_code (mapping, output)
  output.map {|code| code.split(//).map{|c| mapping.key(c)}.sort.join}
end

def process_part1
  data = load(day:"08", is_test: false)  

  disp_size = [6,2,5,5,4,5,6,3,7,6]
  uniq_sizes = disp_size.select {|x| disp_size.count(x) == 1}
  puts data.map {|x| x[1]}.flatten.select {|y| uniq_sizes.include?(y.length)}.size
end


def process_part2
  data = load(day:"08", is_test: false)  
  segments = {"abcefg" => 0, "cf" => 1, "acdeg"=> 2, "acdfg"=> 3, "bcdf"=> 4, "abdfg"=> 5, "abdefg"=> 6, "acf"=> 7, "abcdefg"=> 8, "abcdfg"=> 9}
  code = 0
  data.each do |input|
    pattern = input[0]
    output = input[1]
    mapping = get_mapping(pattern)
    correct_output = get_correct_code(mapping, output)
    code += correct_output.map {|c| segments[c].to_s}.join.to_i
  end
  puts code
end

def process
  process_part2 
end