require 'spec_helper'
require 'sectors_data'

describe Rwanda do
  r = Rwanda.instance
  
  # Singular Ofs
  
  describe '.district_of' do
    it 'knows the distict(s) of a sector' do
      # Unfortunately, there are multiple sectors with the same name in different districts
      # so this cannot give a unique response all of the time
      # e.g. Busasamana in Nyanza and Rubavu
      expect(r.district_of('Jali')).to eq 'Gasabo'
      expect(r.district_of('jAlI')).to eq 'Gasabo'
      
      # Returns districts in alphabetical order
      expect(r.district_of('Busasamana')).to eq [ 'Nyanza', 'Rubavu' ].sort
      
      expect(r.district_of('Foobar')).to eq nil
    end
  end
  
  describe '.province_of' do
    it 'knows the province of a district, and can return it in Kinyarwanda' do 
      expect(r.province_of('gaSABO')).to eq 'Kigali City'
      expect(r.province_of('Foobar')).to eq nil
      expect(r.province_of('gaSABO', true)).to eq 'Umujyi wa Kigali'
      expect(r.province_of('Foobar')).to eq nil
    end
  end
  
  # Plural Ofs
  
  describe '.districts_of' do
    it 'knows all the districts of each province' do
      expect(r.districts_of('Kigali City').sort).to eq ["Gasabo", "Kicukiro", "Nyarugenge"].sort
      expect(r.districts_of('kigali city').sort).to eq ["Gasabo", "Kicukiro", "Nyarugenge"].sort
      expect(r.districts_of('Foobar')).to eq nil
    end
  end
  
  describe '.sectors_of' do
    
    it 'knows all the sectors of a district' do
      expect(r.sectors_of('GasABO').sort).to eq [ 'Bumbogo', 'Gatsata', 'Gikomero', 'Gisozi', 'Jabana', 'Jali', 'Kacyiru', 'Kimihurura', 'Kimironko', 'Kinyinya', 'Ndera', 'Nduba', 'Remera', 'Rusororo', 'Rutunga' ].sort
      expect(r.sectors_of('Foobar')).to eq nil
    end
  end
  
  # Below this level it is no longer possible to use strings because there are mulitple sectors with the same name
  
  describe '.cells_of' do
    it 'knows all the cells of a sector' do
      # Nyagatare,Mimuri,Mahoro,Rubumba
      expect(r.cells_of('Nyagatare', 'Mimuri')).to eq ['Bibare', 'Gakoma', 'Mahoro', 'Mimuri', 'Rugari']
      expect(r.cells_of('nyagatare', 'MIMURI')).to eq ['Bibare', 'Gakoma', 'Mahoro', 'Mimuri', 'Rugari']
    end
  end
  
  describe '.villages_of' do
    it 'knows all the villages of a cell' do
      expect(r.villages_of('Ruhango', 'Ruhango', 'Gikoma')).to eq ['Gatengeri', 'Gikumba', 'Karama', 'Murambi', 'Nangurugomo', 'Nyarusange', 'Rebero', 'Rubiha', 'Rurembo', 'Ryabonyinka', 'Wimana']
      expect(r.villages_of('RuhANgo', 'RUHANGO', 'GIKOMA')).to eq ['Gatengeri', 'Gikumba', 'Karama', 'Murambi', 'Nangurugomo', 'Nyarusange', 'Rebero', 'Rubiha', 'Rurembo', 'Ryabonyinka', 'Wimana']
    end
  end
  
  describe '.subdivisions_of' do
    it 'knows the sub-divisions of a district, sector or cell' do
      expect(r.subdivisions_of(['Ruhango', 'Ruhango', 'Gikoma'])).to eq ['Gatengeri', 'Gikumba', 'Karama', 'Murambi', 'Nangurugomo', 'Nyarusange', 'Rebero', 'Rubiha', 'Rurembo', 'Ryabonyinka', 'Wimana']
      expect(r.subdivisions_of(['RuhANgo', 'RUHANGO', 'GIKOMA'])).to eq ['Gatengeri', 'Gikumba', 'Karama', 'Murambi', 'Nangurugomo', 'Nyarusange', 'Rebero', 'Rubiha', 'Rurembo', 'Ryabonyinka', 'Wimana']
      expect(r.subdivisions_of([])).to eq r.districts.sort
    end
  end
  
  # Lists
  
  describe '.provinces' do
    it 'can list the provinces of Rwanda' do
      expect(r.provinces.sort).to eq ["Kigali City", "Western Province", "Northern Province", "Southern Province", "Eastern Province"].sort
    end
  end
  
  describe '.districts' do
    let(:output) { r.districts }
    
    it 'can list the districts of Rwanda' do
      expect(output.sort).to eq ["Nyarugenge", "Gasabo", "Kicukiro", "Nyanza", "Gisagara", "Nyaruguru", "Huye", "Nyamagabe", "Ruhango", "Muhanga", "Kamonyi", "Karongi", "Rutsiro", "Rubavu", "Nyabihu", "Ngororero", "Rusizi", "Nyamasheke", "Rulindo", "Gakenke", "Musanze", "Burera", "Gicumbi", "Rwamagana", "Nyagatare", "Gatsibo", "Kayonza", "Kirehe", "Ngoma", "Bugesera"].sort
    end
  end
  
  describe '.sectors' do
      it 'can list the sectors of Rwanda' do
      expect(r.sectors.count).to eq 416
      r.sectors.each_with_index do |s,i|
        expect(s).to eq SECTORS[i]
      end
    end
  end
  
  # Fuzzy Matching
  
  describe '.[division]_like' do
    it 'can offer suggestions for mis-typed provinces' do
      expect(r.province_like('Westrun Provinc')).to eq 'Western Province'
      expect(r.province_like('westrun provinc')).to eq 'Western Province'
    end
    it 'can offer suggestions for mis-typed districts' do
      expect(r.district_like('Gasabu')).to eq 'Gasabo'
    end
    it 'can offer suggestions for mis-typed sectors' do
      expect(r.sector_like('Kazu')).to eq 'Kazo'
    end
  end
  
  # Testing
  
  describe '.is_[division]?' do
    it 'knows whether a division exists, even if the case is wrong' do
      expect(r.is_district? 'Karongi').to eq true
      expect(r.is_sector? 'Gashari').to eq true
      expect(r.is_cell? 'Musasa').to eq true
      expect(r.is_village? 'Kaduha').to eq true
      expect(r.is_district? 'Karoooongi').to eq false
      expect(r.is_sector? 'Gashariii').to eq false
      expect(r.is_cell? 'Musasasasasa').to eq false
      expect(r.is_village? 'Kaduhahaha').to eq false

      expect(r.is_district? 'karongi').to eq true
      expect(r.is_sector? 'gashari').to eq true
      expect(r.is_cell? 'musasa').to eq true
      expect(r.is_village? 'kaduha').to eq true
      expect(r.is_district? 'karoooongi').to eq false
      expect(r.is_sector? 'gashariii').to eq false
      expect(r.is_cell? 'musasasasasa').to eq false
      expect(r.is_village? 'kaduhahaha').to eq false
    end
  end
  
  describe '.exist?' do
    it 'knows whether a chain of divisions is legitimate, case insensitively' do
      expect(r.exist?('Karongi','Bwishyura','Kiniha','Nyarurembo')).to eq true
      expect(r.exist?('Karongi','Bwishyura','Nyarurembo')).to eq false
      expect(r.exist?('Karongi')).to eq true

      expect(r.exist?('karongi','bwishyura','kiniha','nyarurembo')).to eq true
      expect(r.exist?('karongi','bwishyura','nyarurembo')).to eq false
      expect(r.exist?(nil,nil,'',nil)).to eq false
      expect(r.exist?('karongi')).to eq true

      # .exists? is an acceptable synonym
      expect(r.exists?('Karongi','Bwishyura','Kiniha','Nyarurembo')).to eq true
      expect(r.exists?('karongi')).to eq true
    end
  end
  
  describe '.valid?' do
    it 'knows whether a chain of divisions is valid, which an empty set is' do
      expect(r.valid?('Karongi','Bwishyura','Kiniha','Nyarurembo')).to eq true
      expect(r.valid?(nil,nil,nil)).to eq true
      
      expect(r.valid?('Karongi','Bwishyura','Nyarurembo')).to eq false
      expect(r.valid?(nil,nil,'',nil)).to eq false
    end
  end
  
  describe '.translate' do
    it 'can translate a province from English to Kinyarwanda' do
      expect(r.translate('Northern Province')).to eq 'Amajyaruguru'
      expect(r.translate('Southern Province')).to eq 'Amajyepfo'
      expect(r.translate('eastern province')).to eq 'Iburasirazuba'
      expect(r.translate('WESTERN PROVINCE')).to eq 'Iburengerazuba'
      expect(r.translate('Kigali City')).to eq 'Umujyi wa Kigali'
      expect(r.translate('foobar')).to eq nil
    end
    it 'can translate a province from Kinyarwanda to English' do
      expect(r.translate('Amajyaruguru')).to eq 'Northern Province'
      expect(r.translate('AmajyePFO')).to eq 'Southern Province'
      expect(r.translate('Iburasirazuba')).to eq 'Eastern Province'
      expect(r.translate('Iburengerazuba')).to eq 'Western Province'
      expect(r.translate('umujyi wa kigali')).to eq 'Kigali City'
    end
  end
  
  describe '.where_is?' do
    it 'can list all of the divisions by a certain name' do
      expect(STDOUT).to receive(:puts).with("Rwanda has 0 districts, 1 sector, 1 cell, and 1 village called Ndego:\n  Ndego is a sector in Kayonza District, Eastern Province\n  Ndego is a cell in Karama Sector, Nyagatare District, Eastern Province\n  Ndego is a village in Ndego Cell, Karama Sector, Nyagatare District, Eastern Province\n")
      r.where_is? 'ndego'
      expect(STDOUT).to receive(:puts).with("Rwanda has no divisions called Foobar\n")
      r.where_is? 'Foobar'
    end
  end
  
  describe '#first' do
    it 'can provide the first village in the list' do
      row = {'province' => "Eastern Province", 'district' => "Bugesera", 'sector' => "Gashora", 'cell' => "Biryogo", 'village' => "Bidudu"}
      v = Village.new(row)
      expect(r.first).to eq v
    end
  end
end  
  
