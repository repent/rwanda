#!/usr/bin/env ruby

require 'rwanda/version'
#require 'rwanda/data'
require 'fuzzy_match'
require 'csv'
require 'pry'

#binding.pry

DATA = 'lib/rwanda/data.csv'

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
  
  def initialize
    @villages = []
    CSV.foreach(DATA, headers: :first_row) do |row|
      villages << Village.new(row)
    end
  end
  # Singular Ofs ((
  # )) Plural Ofs ((
  # )) Lists ((
  def provinces; @villages.collect{|v| v.province}.uniq; end
  def districts; @villages.collect{|v| v.district}.uniq; end
  def sectors; @villages.collect{|v| v.sector}.uniq; end
  
  # )) Matching
end

#rw=Rwanda.new
#puts rw.villages

#binding.pry