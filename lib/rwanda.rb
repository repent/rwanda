#!/usr/bin/env ruby

require 'rwanda/version'
#require 'rwanda/data'
require 'fuzzy_match'
require 'csv'
require 'pry'

#binding.pry

DATA = 'lib/rwanda/data.csv'

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
  
  #def initialize(province, district, sector, cell, village)
  def initialize(row)
    #@province,@district,@sector,@cell,@village=province,district,sector,cell,village
    @province,@district,@sector,@cell,@village=row['province'],row['district'],row['sector'],row['cell'],row['village']
  end
  def to_s
    "#{@province}/#{@district}/#{@sector}/#{@cell}/#{@village}"
  end
end

class Rwanda
  attr_accessor :villages
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
    village = @villages.select_first {|v| v.district == district}
    if village
      if rw then RW[village.province] else village.province end
    else
      nil
    end
  end
  def district_of(sector)
    village = @villages.select_first {|v| v.sector == sector}
    village ? village.district : nil
  end
  # )) Plural Ofs ((
  def districts_of(province)
    districts = @villages.select {|v| v.province == province }.collect {|v| v.district}.uniq
    #binding.pry
    districts.empty? ? nil : districts
  end
  def sectors_of(district)
    sectors = @villages.select {|v| v.district == district }.collect {|v| v.sector}.uniq
    sectors.empty? ? nil : sectors
  end
  # )) Lists ((
  def provinces; @villages.collect{|v| v.province}.uniq; end
  def districts; @villages.collect{|v| v.district}.uniq; end
  # already introduces ambiguity from sectors down: 37 districts are duplicate names
  def sectors
    @sectors ||= @villages.collect {|v| [v.district, v.sector] }.uniq.collect {|ds| ds[1]}.sort
    #@villages.collect{|v| v.sector}.uniq
  end
  
  # )) Matching
  def division_like(division)
  
  end
end

#rw=Rwanda.new
#puts rw.villages

