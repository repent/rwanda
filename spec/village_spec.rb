require 'spec_helper'

describe Village do
  r = Rwanda.instance
  v = r.first
  v_full_hash = {:province => "Eastern Province", :district => "Bugesera", :sector => "Gashora", :cell => "Biryogo", :village => "Bidudu"}
  v_limited_hash = {:district => "Bugesera", :sector => "Gashora", :cell => "Biryogo"}

  describe '#to_h' do
    it 'can convert the contents of village to a customised hash' do
      expect(v.to_h).to eq v_full_hash
      expect(v.to_h(:district, :sector, :cell)).to eq v_limited_hash
    end
  end
end
