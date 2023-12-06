def compare(p1, p2)  
  (0..p1.size-1).each do |i|
    left = p1[i]; right = p2[i]
    left_type, right_type = [left.class.to_s, right.class.to_s]
    case 
      when left_type == "Integer" and right_type == "Integer"
        if 
    end
  end
end

def load(is_test: true)
  file_path = File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__)
  lines = File.read(file_path).split("\n\n").map { |l| l.split("\n").map {|m| eval(m)}}  
end

def process_part1
  data = load(is_test: true)
  data.each {|d| compare(d[0], d[1])}
end

def process_part2

end

def process
  process_part1
end
