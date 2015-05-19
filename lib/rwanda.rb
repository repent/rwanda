#!/usr/bin/env ruby

require 'rwanda/version'
#require 'rwanda/data'
require 'fuzzy_match'
require 'csv'
require 'pry'

DATA = File.join(File.dirname(File.expand_path(__FILE__)), 'rwanda/data.csv')

class Array
  def select_first
    self.each do |el|
      return el if yield(el)
    end
    nil
  end
end

class Village
  attr_accessor :province, :district, :sector, :cell, :village
  
  def initialize(row)
    @province,@district,@sector,@cell,@village=row['province'],row['district'],row['sector'],row['cell'],row['village']
  end
  def to_s
    "#{@province}/#{@district}/#{@sector}/#{@cell}/#{@village}"
  end
  def match(str)
    matches = []
    Rwanda::DIVISIONS.each do |div|
      if str.downcase == self.send(div).downcase
        matches.push div
      end
    end
    matches
  end
  def [](n)
    raise "Division index #{n} out of range!  Permitted indices 0 (province) to 4 (village)"
    self.send(Rwanda.DIVISIONS[n])
  end
end

class Rwanda
  attr_accessor :villages
  DIVISIONS=[:province,:district,:sector,:cell,:village]
  RW = {
    'Northern Province' => 'Amajyaruguru',
    'Southern Province' => 'Amajyepfo',
    'Eastern Province' => 'Iburasirazuba',
    'Western Province' => 'Iburengerazuba',
    'Kigali City' => 'Umujyi wa Kigali'
  }
  
  def initialize
    @villages = []
    CSV.foreach(DATA, headers: :first_row) do |row|
      villages << Village.new(row)
    end
  end

  # Singular Ofs ((
  def province_of(district, rw=false)
    village = @villages.select_first {|v| v.district.downcase == district.downcase}
    if village
      if rw then RW[village.province] else village.province end
    else
      nil
    end
  end
  def district_of(sector)
    village = @villages.select_first {|v| v.sector.downcase == sector.downcase}
    village ? village.district : nil
  end
  # )) Plural Ofs ((
  def districts_of(province)
    districts = @villages.select {|v| v.province.downcase == province.downcase }.collect {|v| v.district}.uniq
    #binding.pry
    districts.empty? ? nil : districts
  end
  def sectors_of(district)
    sectors = @villages.select {|v| v.district.downcase == district.downcase }.collect {|v| v.sector}.uniq
    sectors.empty? ? nil : sectors
  end
  def cells_of(district, sector)
    @villages.select {|v| v.district.downcase == district.downcase and v.sector.downcase == sector.downcase}.collect {|v| v.cell}.uniq
  end
  def villages_of(district, sector, cell)
    @villages.select {|v| v.district.downcase == district.downcase and v.sector.downcase == sector.downcase and v.cell.downcase == cell.downcase}.collect {|v| v.village}
  end
  def subdivisions_of(arr)
    case arr.length
      when 1
        sectors_of *arr
      when 2
        cells_of *arr
      when 3
        villages_of *arr
      else
        raise "subdivisions_of requires an array of between 1 and 3 elements (do NOT include a province): received #{arr}"
    end
  end
  # )) Calleds ((
  #def districts_called(district)
  #  @villages
  #end
  # )) Lists ((
  def provinces; @villages.collect{|v| v.province}.uniq; end
  def districts; @villages.collect{|v| v.district}.uniq; end
  # already introduces ambiguity from sectors down: 37 districts are duplicate names
  def sectors
    @sectors ||= @villages.collect {|v| [v.district, v.sector] }.uniq.collect {|ds| ds[1]}.sort
    #@villages.collect{|v| v.sector}.uniq
  end
  
  # )) Matching ((
  def province_like(province)
    @fmp ||= FuzzyMatch.new(provinces)
    @fmp.find(province)
  end
  def district_like(district)
    @fmd ||= FuzzyMatch.new(districts)
    @fmd.find(district)
  end
  def sector_like(sector)
    # Already problematic here: there are identical sector names
    @fms ||= FuzzyMatch.new(sectors)
    @fms.find(sector)
  end
  
  # )) Testing ((
  #def is_province?(province); @villages.any? {|v| v.province == province}; end
  # is_division?
  DIVISIONS.each do |division|
    define_method("is_#{division}?") do |argument|
      @villages.any? {|v| v.send(division).downcase == argument.downcase}
    end
  end
  def exist?(district=false, sector=false, cell=false, village=false)
    villages = @villages.dup
    return nil unless district
    {district: district, sector: sector, cell: cell, village: village}.each_pair do |division_name,division|
      #binding.pry
      return true unless division
      villages.select! {|v| v.send(division_name).downcase == division.downcase}
      return false if villages.empty?
    end
    true    
  end
  def exists?(*p); exist?(*p); end
  
  # )) Translation ((
  def translate(province)
    kin = RW.find { |eng,kin| eng.downcase == province.downcase } # returns [key, val]
    return kin[1] if kin
    eng = RW.find { |eng,kin| kin.downcase == province.downcase }
    return eng[0] if eng
    nil
    #if RW.has_key? province
    #  RW[province]
    #elsif RW.has_value? province
    #  RW.key province
    #else
    #  nil
    #end
  end
  
  # )) Where is...? ((
  def where_is?(division)
    matching = { province: [], district: [], sector: [], cell: [], village: [] }
    lines = []
    @villages.each do |village|
      matches = village.match(division)
      unless matches.empty?
        matches.each do |match|
          matching[match].push village
          # convert villages into lines
          case match
            when :district
              lines << '  ' + village.district + " is a district"
            when :sector
              lines << '  ' + village.sector + " is a sector in " + village.district
            when :cell
              lines << '  ' + village.cell + " is a cell in " + village.sector + ", " + village.district
            when :village
              lines << '  ' + village.village + " is a village in " + [ village.cell, village.sector, village.district ].join(', ')
          end
        end
      end
    end
    lines.uniq!
    #counts = matching.inject({}) {|h,(k,v)| h[k] = d.count; h }
    output = ''
    
    # summary line
    if lines.empty?
      output += "Rwanda has no divisions called #{division.capitalize}\n"
    else
      output += 'Rwanda has'
      n = []
      comma = ''
      (0..3).each do |i|
        n = lines.count { |l| l.count(',') == i }
        output << "#{comma} #{i == 3 ? 'and ' : ''}#{n} #{Rwanda::DIVISIONS[i+1]}#{n == 1 ? '' : 's'}"
        comma = ','
      end
      output << " called #{division.capitalize}:\n"
    end
    
    # detail
    lines.each { |line| output << line << "\n" }
    output 
  end
end

