# https://adventofcode.com/2021/day/10

def load (day: ,is_test: false)
  sample = is_test ? "-sample" : ""
  file_path = File.expand_path("../day-#{day}#{sample}.txt", __FILE__)
  lines = File.readlines(file_path)  
  
  #format input
  lines.map {|line| line.strip.split(//)}
end

def assess_line(line)
  parens = {")" => "(", "]" => "[", "}" => "{", ">" => "<"}
  close_parens = parens.keys
  open_parens = parens.values
  penalty = {")" => 3, "]" => 57, "}" => 1197, ">" => 25137}
  last_open = ""
  exp = []
  response = {:state => "", :errors => [], :penalty => 0, :exp => [], :score => 0}

  line.each do |p| 
    if open_parens.include? p
      exp.push p      
    else
      unless (exp[-1] == parens[p])
        response[:penalty] = penalty[p]
        response[:state] = "corrupted"
        break
      else
        exp.pop
      end
    end
  end
  
  response[:exp] = line

  response[:state] = response[:state]  == "corrupted" ? response[:state] : (exp.size > 0) ? "incomplete" : "valid" 

  if response[:state] == "incomplete"
    response[:score] = correct_exp(response[:exp])
  end

  response
end

def correct_exp (exp)
  puts exp.join.to_s
  parens = {")" => "(", "]" => "[", "}" => "{", ">" => "<"}
  score = {")" => 1, "]" => 2, "}" => 3, ">" => 4}
  cor = []
  while exp.size > 0 do 
    cor << parens.key(exp[-1])
    exp.pop
  end

  puts cor.join.to_s
  sum = 0
  cor.each {|p|  sum += (sum * 5) + score[p]}  

  sum
end

def process_part1
  data = load(day:"10", is_test: true)  
    
  puts data.map {|d| assess_line(d)}
end

def process_part2
  data = load(day:"10", is_test: true)  
  incomplete = data.map {|d| assess_line(d)}.select {|d| d[:state] == "incomplete"}

  puts incomplete.map {|i| i[:exp]}.reduce {|sum, e| sum += correct_exp(e)}
end

def process
  process_part1
end