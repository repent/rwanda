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
    raise "Division index #{n} out of range!  Permitted indices 0 (province) to 4 (village)" unless (0..4).include? n
    self.send(Rwanda::DIVISIONS[n])
  end
  def to_h(*options = [:province, :district, :sector, :cell, :village])
    options.collect {|l| [ l, self[l] ] }.to_h
  end
end
