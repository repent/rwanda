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
  def exist?(district, sector=false, cell=false, village=false)
    villages = @villages.dup
    return false unless district
    {district: district, sector: sector, cell: cell, village: village}.each_pair do |division_name,division|
      #binding.pry
      return true unless division
      villages.select! {|v| v.send(division_name).downcase == division.downcase}
      return false if villages.empty?
    end
    true    
  end
  
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
end

