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
  def to_h(*options)
    options = [:province, :district, :sector, :cell, :village] if options.empty?
    # this use of Array#to_h is only available from 2.1.0 onwards
    options.collect {|l| [ l, instance_variable_get("@#{l}") ] }.to_h
  end
  def ==(other)
    to_h == other.to_h
  end
end
