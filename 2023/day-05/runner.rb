def load(is_test = true)
  file_path = File.expand_path("../data#{is_test ? '-sample' : ''}.txt", __FILE__)

  lines = File.readlines(file_path)
end

def process_part1(input)
  almanac = Almanac.new(input)
  #uts almanac.get_lowest_loc
  puts almanac.get_loc(562444630)
end

def process_part2(input); end

def process
  input = load(true)
  process_part1(input)
end

class Almanac
  attr_accessor :seeds, :fert, :water, :light, :temp, :hum, :loc, :maps

  def initialize(lines)
    sd2sl = sl2fr = fr2wr = wr2lt = lt2tp = tp2hd = hd2lo = {}
    @seeds = lines[0].split(':')[1].strip.split(' ').map(&:to_i)
    @maps = {}
    maplines = []
    maptype = nil
    (2..lines.length - 1).each do |i|
      #puts lines[i]
      if lines[i].match(/[a-z]/)
        maptype = lines[i].split(' ')[0].to_sym
        #puts maptype
      elsif lines[i].match(/[0-9]/)        
        maplines << lines[i]
        #puts maplines.size
      elsif lines[i].strip.length == 0
        #puts 'in here'
        @maps[maptype] = Map.new(maplines)
        maplines = []
        maptype = nil
        #puts @maps
      end
    end

    #puts @maps
  end

  def get_loc(seed)
    return @maps[:"humidity-to-location"].get_dest(
            @maps[:"temperature-to-humidity"].get_dest(
              @maps[:"light-to-temperature"].get_dest(
                @maps[:"water-to-light"].get_dest(
                  @maps[:"fertilizer-to-water"].get_dest(
                    @maps[:"soil-to-fertilizer"].get_dest(
                      @maps[:"seed-to-soil"].get_dest(seed)
                    )
                  )
                )                
              )
            ))
  end

  def get_lowest_loc
    @seeds.map{|s| get_loc(s)}.min
  end
end

class Map
  attr_accessor :src_ranges, :dest_ranges

  def initialize(lines)
    @src_ranges = []
    @dest_ranges = []
    lines.each do |line|
      dest, src, range_len = line.split(' ').map(&:to_i)
      @dest_ranges << (dest..dest + range_len - 1)
      @src_ranges << (src..src + range_len - 1)
    end
  end

  def get_dest(source)    
    @src_ranges.each_with_index do |src_range, i|
      #puts "#{src_range.first},#{src_range.last},#{source}"
      return @dest_ranges[i].first + (source - src_range.first) if src_range.include?(source)
    end    
    source # return the source if explicit makking is not found
  end
end
