require 'spect_helper'

describe Village do
  r = Rwanda.instance
  v = r.first

  describe '#to_h' do
    it 'can convert the contents of village to a customised hash' do
      expect(v.to_h).to eq []
      expect(v.to_h(:district, :sector, :cell).to eq []
    end
  end
end
