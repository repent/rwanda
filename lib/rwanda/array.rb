class Array
  def select_first
    self.each do |el|
      return el if yield(el)
    end
    nil
  end
end
