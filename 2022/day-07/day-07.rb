class ElfFile
  def initialize (name, size)
    @name = name
    @size = size
  end

  attr_accessor :name, :size
end

class ElfDir
  def initialize (name, parent)
    @name = name
    @parent = parent
    @dirs = []
    @files = []
    @cap = 10000
  end

  def add_dir (name)
    @dirs << ElfDir.new(name, self)
  end

  def add_file (name, size)
    @files << ElfFile.new(name, size)
  end

  def make_or_get_dir (name)    
    add_dir(name) unless @dirs.find {|d| d.name == name}
    
    @dirs.find {|d| d.name == name}
  end

  def get_parent
    @parent ? @parent : self
  end

  def sizes
    sizes = []
   @dirs.each {|d| d.size}  
  end
  
  def size
    ff = @files.map {|f| f.size}
    dd = @dirs.map {|d| d.size}
    #puts "#{ff} #{dd}"
    ds =  ff.reduce(&:+) + (dd.empty? ? 0 : dd.reduce(&:+)) 

    ds
  end

  def to_s    
    @dirs.map {|d| d.name}
  end
  
  attr_accessor :name, :dirs, :files, :parent
end

def processor(lines)  
  root = ElfDir.new("/",nil) 
  pwd = root #present working directory
  lines.each do |line|
    #puts line
    case line
      when /\$ cd (.*)/
        dirname = $1
        case dirname
          when "/"
            pwd = root
          when ".."
            pwd = pwd.get_parent
        else 
          pwd = pwd.make_or_get_dir (dirname)
        end        
      when /dir (.*)/
        pwd.make_or_get_dir ($1)
      when /(\d+) (.*)/
        pwd.add_file($2, $1.to_i)
    else
      
    end
    #puts pwd.name
  end

  puts root.sizes.to_s
  puts root.sizes.select {|s| s.reduce(&:+) < 100000}.to_s #.reduce(&:+)
end


def load (is_test: true)      
  file_path =  File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__) 
  lines = File.readlines(file_path)  

  processor(lines)
end


def process_part1
  load(is_test: true)
end


def process_part2  
  load(is_test: true)
end

def process
  process_part1
end