require 'spec_helper'

describe Location do
  district = Location.new 'Karongi'
  sector = Location.new 'Karongi','Bwishyura'
  cell = Location.new 'Karongi','Bwishyura','Kiniha'
  village = Location.new 'Karongi','Bwishyura','Kiniha','Nyarurembo'
  none = Location.new
  invalid = Location.new 'Karongi', 'Kiniha', 'Bwishyura', 'Nyarurembo'

  describe '.top, .bottom, upto, downto' do
    it 'can list the divisions up or down to a certain level' do
      expect(village.top(1)).to eq ['Karongi']
      expect(village.top(3)).to eq ['Karongi','Bwishyura','Kiniha']
      expect(village.bottom(1)).to eq ['Nyarurembo']
      expect(sector.bottom(1)).to eq []
      expect(village.upto(:sector)).to eq ['Bwishyura','Kiniha','Nyarurembo'].reverse
      expect(village.downto(:sector)).to eq ['Karongi','Bwishyura']
    end
  end

  describe 'Location.index_of' do
    it 'can convert a division name into a number' do
      expect(Location.index_of(:district)).to eq 1
      expect(Location.index_of(:sector)).to eq 2
      expect(Location.index_of(:cell)).to eq 3
      expect(Location.index_of(:village)).to eq 4
    end
  end
  
  describe 'valid? and validate!' do
    it 'can tell if a location is valid, and clean invalid information' do
      expect(cell.valid?).to eq true
      expect(invalid.valid?).to eq false
      
      fixed = invalid.validate!
      expect(fixed).to eq Location.new 'Karongi'
    end
  end
  
  describe 'first_missing' do
    it 'can identify the first "missing" division' do
      expect(sector.first_missing).to eq :cell
      expect(cell.first_missing).to eq :village
      expect(village.first_missing).to eq false
    end
  end
  
  describe 'to_s' do
    it 'can output a location in human-readable form' do
      expect(village.to_s).to eq 'Karongi District, Bwishyura Sector, Kiniha Cell, Nyarurembo Village'
      expect(sector.to_s).to eq 'Karongi District, Bwishyura Sector'
      expect(Location.new.to_s).to eq 'Unknown'
    end
  end
  
  describe 'division, division_names' do
    it 'can list divisions and division names' do
      expect(village.division_names).to eq [:district, :sector, :cell, :village]
      expect(cell.divisions).to eq ['Karongi','Bwishyura','Kiniha',nil]
      expect(district.n_divisions).to eq 4
    end
  end
end
