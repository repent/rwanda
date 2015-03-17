require "rwanda/version"
require "rwanda/data"
require "fuzzy_match"

class Rwanda
  # Province, District, Sector, Cell?, Village?
  
  # Singular Ofs ((
  
  def district_of(sector)
    districts_with_sectors.each do |d,s_array|
      return d if s_array.include? sector
    end
    nil
  end
  def province_of(district)
    Province.each do |p,d_array|
      return p if d_array.include? district
    end
    nil
  end
  
  # )) Plural Ofs ((
  
  def districts_of(province)
    return nil unless Province[province]
    Province[province].collect {|d,s| d}
  end
  def sectors_of(district)
    districts_with_sectors[district]
  end

  # )) Lists ((
  
  def provinces; Province.keys; end
  def districts; Province.collect {|p,d| d.collect {|d,s| d}}.flatten; end
  def sectors; Province.collect {|p,d| d.collect {|d,s| s}}.flatten; end
  
  # )) Fuzzy Matching ((
  
  def district_like(district)
    @fd ||= FuzzyMatch.new(districts)
    @fd.find(district)
  end
  def province_like(province)
    @fp = FuzzyMatch.new(provinces)
    @fp.find(province)
  end
  def sector_like(sector)
    @fs = FuzzyMatch.new(sectors)
    @fs.find(sector)
  end
  
  # )) Existence ((
  
  def province?(province); provinces.include? province; end
  def district?(district); districts.include? district; end
  def sector?(sector); sectors.include? sector; end
  
  # ))
  
  # imported:
  
  private
  
  def districts_with_sectors
    all_districts_with_sectors = {}
    Province.each do |p,d_hash|
      all_districts_with_sectors.merge!(d_hash)
    end
    all_districts_with_sectors
  end
  #def sectors_with_cells
  #  all_sectors_with_cells = {}
  #  districts_with_sectors.each do |d,s_hash|
  #    all_sectors_with_cells.merge!(s_hash)
  #  end
  #  all_sectors_with_cells
  #end
  #def sector_of(cell)
  #end
end
