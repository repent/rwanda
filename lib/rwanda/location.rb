class Location < Struct.new(:district, :sector, :cell, :village)
  #Rw = Rwanda.instance

  def division_names(strings=false); strings ? self.members.map(&:humanize) : self.members; end
  def divisions(strip_nil=false); strip_nil ? self.to_a.grep(String) : self.to_a; end
  def n_divisions; divisions.count; end
  
  def valid? # is it valid?
    Rwanda.instance.exists? *divisions
  end
  def validate! # get rid of invalid data
    #binding.pry
    each_with_index do |div, n|
      unless Rwanda.instance.exists? *top(n+1)
        return self.cp!(Location.new(*top(n)))
      end
    end
  end
  
  # from district down, always returning an n-element array if keep_nils is set
  def top(n, keep_nils=false)
    keep_nils ? divisions[0...n] : divisions[0...n].compact
  end
  # from district down to and including level
  def downto(level, keep_nils=false)
    d = top(division_names.index(level.to_sym)+1)
    keep_nils ? d : d.compact
  end
  # from village up, starting with the village
  # will be n-element if keep_nils is true
  def bottom(n, keep_nils=false)
    d = divisions.reverse[0...n]
    keep_nils ? d : d.compact
  end
  # from village up to and including level
  def upto(level, keep_nils=false)
    divisions = bottom(n_divisions - division_names.index(level.to_sym))
    keep_nils ? divisions : divisions.compact
  end
  
  def first_missing
    raise "Called first_missing on invalid Location [#{self.to_s}]" unless valid?
    each_pair do |level, div|
      return level if div == nil
    end
    false
  end

  private
  def cp!(other) # copies other's attributes to self
    self.division_names do |level|
      self[:level] = other[:level]
    end
  end
  
  def validate_up_to(threshold, company)
    divisions = []
    (0..threshold).each do |n|
      divisions.push company.read_attribute(DIVISIONS[n]).to_s
    end
    if divisions.blank? # no longer possible
      true
    else
      logger.debug "validate_up_to #{threshold} #{divisions.join(',')}: #{Rw.exist?(*divisions).to_s}"
      Rw.exist?(*divisions)
    end
  end
  def validate_this(division, company)
    validate_up_to(DIVISIONS.index(division), company)
  end
  def validate_higher(division, company)
    return true if division == :district
    validate_up_to((DIVISIONS.index(division)-1), company)
  end
  
  # Class methods
  def self.index_of(division)
    members.index(division) + 1
  end
end
