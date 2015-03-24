require 'spec_helper'

# Source: old national statistics document
OLD_SECTORS=['Base', 'Bigogwe', 'Boneza', 'Bugarama', 'Bugeshi', 'Bukure', 'Bumbogo', 'Bungwe', 'Burega', 'Buruhukiro', 'Busanze', 'Busasamana', 'Busasamana', 'Busengo', 'Bushekeri', 'Bushenge', 'Bushoki', 'Busogo', 'Busoro', 'Butare', 'Butaro', 'Buyoga', 'Bweramana', 'Bweyeye', 'Bwira', 'Bwishyura', 'Bwisige', 'Byimana', 'Byumba', 'Coko', 'Cyabakamyi', 'Cyabingo', 'Cyahinda', 'Cyanika', 'Cyanika', 'Cyanzarwe', 'Cyato', 'Cyeru', 'Cyeza', 'Cyinzuzi', 'Cyumba', 'Cyungo', 'Cyuve', 'Fumbwe', 'Gacaca', 'Gacurabwenge', 'Gahanga', 'Gahara', 'Gahengeri', 'Gahini', 'Gahunga', 'Gakenke', 'Gasaka', 'Gasange', 'Gashaki', 'Gashanda', 'Gashenyi', 'Gashonga', 'Gashora', 'Gataraga', 'Gatare', 'Gatebe', 'Gatenga', 'Gatore', 'Gatsata', 'Gatsibo', 'Gatumba', 'Gatunda', 'Gihango', 'Giheke', 'Gihombo', 'Gihundwe', 'Gikomero', 'Gikondo', 'Gikonko', 'Gikundamvura', 'Gisenyi', 'Gishamvu', 'Gishari', 'Gishari', 'Gishubi', 'Gishyita', 'Gisozi', 'Gitambi', 'Gitega', 'Gitesi', 'Giti', 'Gitoki', 'Gitovu', 'Hindiro', 'Huye', 'Jabana', 'Jali', 'Janja', 'Jarama', 'Jenda', 'Jomba', 'Juru', 'Kabacuzi', 'Kabagari', 'Kabare', 'Kabarondo', 'Kabarore', 'Kabatwa', 'Kabaya', 'Kacyiru', 'Kaduha', 'Kagano', 'Kagarama', 'Kageyo', 'Kageyo', 'Kageyo', 'Kagogo', 'Kamabuye', 'Kamegeri', 'Kamembe', 'Kamubuga', 'Kanama', 'Kaniga', 'Kanjongo', 'Kanombe', 'Kansi', 'Kanyinya', 'Kanzenze', 'Karago', 'Karama', 'Karama', 'Karama', 'Karambi', 'Karambo', 'Karangazi', 'Karembo', 'Karenge', 'Karengera', 'Katabagemu', 'Kavumu', 'Kayenzi', 'Kayumbu', 'Kazo', 'Kibangu', 'Kibeho', 'Kibilizi', 'Kibirizi', 'Kibirizi', 'Kibumbwe', 'Kibungo', 'Kicukiro', 'Kigabiro', 'Kigali', 'Kigarama', 'Kigarama', 'Kigembe', 'Kigeyo', 'Kigina', 'Kigoma', 'Kigoma', 'Kimihurura', 'Kimironko', 'Kimisagara', 'Kimonyi', 'Kinazi', 'Kinazi', 'Kinigi', 'Kinihira', 'Kinihira', 'Kinoni', 'Kintobo', 'Kinyababa', 'Kinyinya', 'Kiramuruzi', 'Kirehe', 'Kirimbi', 'Kisaro', 'Kitabi', 'Kivu', 'Kivumu', 'Kivuruga', 'Kivuye', 'Kiyombe', 'Kiyumba', 'Kiziguro', 'Macuba', 'Mageragere', 'Mahama', 'Mahembe', 'Mamba', 'Manihira', 'Manyagiro', 'Maraba', 'Mareba', 'Masaka', 'Masoro', 'Mata', 'Mataba', 'Matimba', 'Matyazo', 'Mayange', 'Mbazi', 'Mbazi', 'Mbogo', 'Mbuye', 'Mimuli', 'Minazi', 'Miyove', 'Mpanga', 'Mubuga', 'Mudende', 'Mugano', 'Muganza', 'Muganza', 'Muganza', 'Mugesera', 'Mugina', 'Mugombwa', 'Mugunga', 'Muhanda', 'Muhanga', 'Muhazi', 'Muhima', 'Muhondo', 'Muhororo', 'Muhoza', 'Muhura', 'Mukama', 'Mukamira', 'Mukarange', 'Mukarange', 'Mukindo', 'Mukingo', 'Muko', 'Muko', 'Mukura', 'Mukura', 'Munini', 'Munyaga', 'Munyiginya', 'Murama', 'Murama', 'Murambi', 'Murambi', 'Murambi', 'Muringa', 'Murunda', 'Murundi', 'Murundi', 'Mururu', 'Musambira', 'Musange', 'Musanze', 'Musasa', 'Musaza', 'Musebeya', 'Musenyi', 'Musha', 'Musha', 'Musheli', 'Mushikiri', 'Mushishiro', 'Mushonyi', 'Mushubati', 'Mushubi', 'Mutenderi', 'Mutete', 'Mutuntu', 'Muyira', 'Muyongwe', 'Muyumbu', 'Muzo', 'Mwendo', 'Mwiri', 'Mwogo', 'Mwulire', 'Nasho', 'Ndaro', 'Ndego', 'Ndera', 'Ndora', 'Nduba', 'Nemba', 'Nemba', 'Ngamba', 'Ngarama', 'Ngera', 'Ngeruka', 'Ngoma', 'Ngoma', 'Ngoma', 'Ngororero', 'Niboye', 'Nkanka', 'Nkomane', 'Nkombo', 'Nkotsi', 'Nkungu', 'Ntarabana', 'Ntarama', 'Ntongwe', 'Ntyazo', 'Nyabimata', 'Nyabinoni', 'Nyabirasi', 'Nyabitekeri', 'Nyagatare', 'Nyagihanga', 'Nyagisozi', 'Nyagisozi', 'Nyakabanda', 'Nyakabuye', 'Nyakarenzo', 'Nyakariro', 'Nyakiliba', 'Nyamabuye', 'Nyamata', 'Nyamirama', 'Nyamirambo', 'Nyamiyaga', 'Nyamiyaga', 'Nyamugali', 'Nyamyumba', 'Nyange', 'Nyange', 'Nyankenke', 'Nyanza', 'Nyarubaka', 'Nyarubuye', 'Nyarugenge', 'Nyarugenge', 'Nyarugunga', 'Nyarusange', 'Nyundo', 'Nzahaha', 'Nzige', 'Rambura', 'Rangiro', 'Remera', 'Remera', 'Remera', 'Remera', 'Rilima', 'Rongi', 'Rubavu', 'Rubaya', 'Rubengera', 'Rubona', 'Rugabano', 'Rugalika', 'Ruganda', 'Rugarama', 'Rugarama', 'Rugendabari', 'Rugengabari', 'Rugera', 'Rugerero', 'Ruhango', 'Ruhango', 'Ruharambuga', 'Ruhashya', 'Ruheru', 'Ruhuha', 'Ruhunde', 'Rukara', 'Rukira', 'Rukoma', 'Rukomo', 'Rukomo', 'Rukozo', 'Rukumberi', 'Ruli', 'Runda', 'Ruramba', 'Ruramira', 'Rurembo', 'Rurenge', 'Rusarabuge', 'Rusasa', 'Rusatira', 'Rusebeya', 'Rusenge', 'Rushaki', 'Rushashi', 'Rusiga', 'Rusororo', 'Rutare', 'Rutunga', 'Ruvune', 'Rwabicuma', 'Rwamiko', 'Rwaniro', 'Rwankuba', 'Rwaza', 'Rwempasha', 'Rwerere', 'Rweru', 'Rwezamenyo', 'Rwimbogo', 'Rwimbogo', 'Rwimiyaga', 'Rwinkwavu', 'Sake', 'Save', 'Shangasha', 'Shangi', 'Shingiro', 'Shyara', 'Shyira', 'Shyogwe', 'Shyorongi', 'Simbi', 'Sovu', 'Tabagwe', 'Tare', 'Tumba', 'Tumba', 'Twumba', 'Uwinkingi', 'Zaza'].sort

# Source: MINALOC via Annoncée
SECTORS=['Base', 'Bigogwe', 'Boneza', 'Bugarama', 'Bugeshi', 'Bukure', 'Bumbogo', 'Bungwe', 'Burega', 'Buruhukiro', 'Busanze', 'Busasamana', 'Busasamana', 'Busengo', 'Bushekeri', 'Bushenge', 'Bushoki', 'Busogo', 'Busoro', 'Butare', 'Butaro', 'Buyoga', 'Bweramana', 'Bweyeye', 'Bwira', 'Bwishyura', 'Bwisige', 'Byimana', 'Byumba', 'Coko', 'Cyabakamyi', 'Cyabingo', 'Cyahinda', 'Cyanika', 'Cyanika', 'Cyanzarwe', 'Cyato', 'Cyeru', 'Cyeza', 'Cyinzuzi', 'Cyumba', 'Cyungo', 'Cyuve', 'Fumbwe', 'Gacaca', 'Gacurabwenge', 'Gahanga', 'Gahara', 'Gahengeri', 'Gahini', 'Gahunga', 'Gakenke', 'Gasaka', 'Gasange', 'Gashaki', 'Gashanda', 'Gashari', 'Gashenyi', 'Gashonga', 'Gashora', 'Gataraga', 'Gatare', 'Gatebe', 'Gatenga', 'Gatore', 'Gatsata', 'Gatsibo', 'Gatumba', 'Gatunda', 'Gihango', 'Giheke', 'Gihombo', 'Gihundwe', 'Gikomero', 'Gikondo', 'Gikonko', 'Gikundamvura', 'Gisenyi', 'Gishali', 'Gishamvu', 'Gishubi', 'Gishyita', 'Gisozi', 'Gitambi', 'Gitega', 'Gitesi', 'Giti', 'Gitoki', 'Gitovu', 'Hindiro', 'Huye', 'Jabana', 'Jali', 'Janja', 'Jarama', 'Jenda', 'Jomba', 'Juru', 'Kabacuzi', 'Kabagali', 'Kabare', 'Kabarondo', 'Kabarore', 'Kabatwa', 'Kabaya', 'Kacyiru', 'Kaduha', 'Kagano', 'Kagarama', 'Kageyo', 'Kageyo', 'Kageyo', 'Kagogo', 'Kamabuye', 'Kamegeri', 'Kamembe', 'Kamubuga', 'Kanama', 'Kaniga', 'Kanjongo', 'Kanombe', 'Kansi', 'Kanyinya', 'Kanzenze', 'Karago', 'Karama', 'Karama', 'Karama', 'Karambi', 'Karambo', 'Karangazi', 'Karembo', 'Karenge', 'Karengera', 'Katabagemu', 'Kavumu', 'Kayenzi', 'Kayumbu', 'Kazo', 'Kibangu', 'Kibeho', 'Kibilizi', 'Kibirizi', 'Kibirizi', 'Kibumbwe', 'Kibungo', 'Kicukiro', 'Kigabiro', 'Kigali', 'Kigarama', 'Kigarama', 'Kigembe', 'Kigeyo', 'Kigina', 'Kigoma', 'Kigoma', 'Kimihurura', 'Kimironko', 'Kimisagara', 'Kimonyi', 'Kinazi', 'Kinazi', 'Kinigi', 'Kinihira', 'Kinihira', 'Kinoni', 'Kintobo', 'Kinyababa', 'Kinyinya', 'Kiramuruzi', 'Kirehe', 'Kirimbi', 'Kisaro', 'Kitabi', 'Kivu', 'Kivumu', 'Kivuruga', 'Kivuye', 'Kiyombe', 'Kiyumba', 'Kiziguro', 'Macuba', 'Mageregere', 'Mahama', 'Mahembe', 'Mamba', 'Manihira', 'Manyagiro', 'Maraba', 'Mareba', 'Masaka', 'Masoro', 'Mata', 'Mataba', 'Matimba', 'Matyazo', 'Mayange', 'Mbazi', 'Mbazi', 'Mbogo', 'Mbuye', 'Mimuri', 'Minazi', 'Miyove', 'Mpanga', 'Mubuga', 'Mudende', 'Mugano', 'Muganza', 'Muganza', 'Muganza', 'Mugesera', 'Mugina', 'Mugombwa', 'Mugunga', 'Muhanda', 'Muhanga', 'Muhazi', 'Muhima', 'Muhondo', 'Muhororo', 'Muhoza', 'Muhura', 'Mukama', 'Mukamira', 'Mukarange', 'Mukarange', 'Mukindo', 'Mukingo', 'Muko', 'Muko', 'Mukura', 'Mukura', 'Munini', 'Munyaga', 'Munyiginya', 'Murama', 'Murama', 'Murambi', 'Murambi', 'Murambi', 'Muringa', 'Murunda', 'Murundi', 'Murundi', 'Mururu', 'Musambira', 'Musange', 'Musanze', 'Musasa', 'Musaza', 'Musebeya', 'Musenyi', 'Musha', 'Musha', 'Musheri', 'Mushikiri', 'Mushishiro', 'Mushonyi', 'Mushubati', 'Mushubi', 'Mutenderi', 'Mutete', 'Mutuntu', 'Muyira', 'Muyongwe', 'Muyumbu', 'Muzo', 'Mwendo', 'Mwiri', 'Mwogo', 'Mwulire', 'Nasho', 'Ndaro', 'Ndego', 'Ndera', 'Ndora', 'Nduba', 'Nemba', 'Nemba', 'Ngamba', 'Ngarama', 'Ngera', 'Ngeruka', 'Ngoma', 'Ngoma', 'Ngoma', 'Ngororero', 'Niboye', 'Nkanka', 'Nkomane', 'Nkombo', 'Nkotsi', 'Nkungu', 'Ntarabana', 'Ntarama', 'Ntongwe', 'Ntyazo', 'Nyabimata', 'Nyabinoni', 'Nyabirasi', 'Nyabitekeri', 'Nyagatare', 'Nyagihanga', 'Nyagisozi', 'Nyagisozi', 'Nyakabanda', 'Nyakabuye', 'Nyakaliro', 'Nyakarenzo', 'Nyakiriba', 'Nyamabuye', 'Nyamata', 'Nyamirama', 'Nyamirambo', 'Nyamiyaga', 'Nyamiyaga', 'Nyamugari', 'Nyamyumba', 'Nyange', 'Nyange', 'Nyankenke', 'Nyanza', 'Nyarubaka', 'Nyarubuye', 'Nyarugenge', 'Nyarugenge', 'Nyarugunga', 'Nyarusange', 'Nyundo', 'Nzahaha', 'Nzige', 'Rambura', 'Rangiro', 'Remera', 'Remera', 'Remera', 'Remera', 'Rilima', 'Rongi', 'Rubavu', 'Rubaya', 'Rubengera', 'Rubona', 'Rugabano', 'Ruganda', 'Rugarama', 'Rugarama', 'Rugarika', 'Rugendabari', 'Rugengabari', 'Rugera', 'Rugerero', 'Ruhango', 'Ruhango', 'Ruharambuga', 'Ruhashya', 'Ruheru', 'Ruhuha', 'Ruhunde', 'Rukara', 'Rukira', 'Rukoma', 'Rukomo', 'Rukomo', 'Rukozo', 'Rukumberi', 'Ruli', 'Runda', 'Ruramba', 'Ruramira', 'Rurembo', 'Rurenge', 'Rusarabuye', 'Rusasa', 'Rusatira', 'Rusebeya', 'Rusenge', 'Rushaki', 'Rushashi', 'Rusiga', 'Rusororo', 'Rutare', 'Rutunga', 'Ruvune', 'Rwabicuma', 'Rwamiko', 'Rwaniro', 'Rwankuba', 'Rwaza', 'Rwempasha', 'Rwerere', 'Rweru', 'Rwezamenyo', 'Rwimbogo', 'Rwimbogo', 'Rwimiyaga', 'Rwinkwavu', 'Sake', 'Save', 'Shangasha', 'Shangi', 'Shingiro', 'Shyara', 'Shyira', 'Shyogwe', 'Shyorongi', 'Simbi', 'Sovu', 'Tabagwe', 'Tare', 'Tumba', 'Tumba', 'Twumba', 'Uwinkingi', 'Zaza'].sort

describe Rwanda do
  r = Rwanda.new
  
  # Singular Ofs
  
  describe '.district_of' do
    let(:input) { 'Jali' }
    let(:output) { r.district_of(input) }
    let(:wrong_in) { 'Foobar' }
    let(:wrong_out) { r.district_of(wrong_in) }
  
    it 'knows the distict of a sector' do
      expect(output).to eq 'Gasabo'
      expect(wrong_out).to eq nil
    end
  end
  
  describe '.province_of' do
    let(:input) { 'Gasabo' }
    let(:output) { r.province_of(input) }
    let(:wrong_in) { 'Foobar' }
    let(:wrong_out) { r.province_of(wrong_in) }
    
    it 'knows the province of a district' do 
      expect(output).to eq 'Kigali City'
      expect(wrong_out).to eq nil
    end
  end
  
  # Plural Ofs
  
  describe '.districts_of' do
    it 'knows all the districts of each province' do
      expect(r.districts_of('Kigali City').sort).to eq ["Gasabo", "Kicukiro", "Nyarugenge"].sort
      expect(r.districts_of('Foobar')).to eq nil
    end
  end
  
  describe '.sectors_of' do
    let(:input) { 'Gasabo' }
    let(:output) { r.sectors_of(input) }
    
    it 'knows all the sectors of a district' do
      expect(output.sort).to eq [ 'Bumbogo', 'Gatsata', 'Gikomero', 'Gisozi', 'Jabana', 'Jali', 'Kacyiru', 'Kimihurura', 'Kimironko', 'Kinyinya', 'Ndera', 'Nduba', 'Remera', 'Rusororo', 'Rutunga' ].sort
      expect(r.sectors_of('Foobar')).to eq nil
    end
  end
  
  # Below this level it is no longer possible to use strings because there are mulitple sectors with the same name
  
  describe '.cells_of' do
    it 'knows all the cells of a sector' do
      # Nyagatare,Mimuri,Mahoro,Rubumba
      expect(r.cells_of('Nyagatare', 'Mimuri')).to eq ['Bibare', 'Gakoma', 'Mahoro', 'Mimuri', 'Rugari']
    end
  end
  
  describe '.villages_of' do
    it 'knows all the villages of a cell' do
      expect(r.villages_of('Ruhango', 'Ruhango', 'Gikoma')).to eq ['Gatengeri', 'Gikumba', 'Karama', 'Murambi', 'Nangurugomo', 'Nyarusange', 'Rebero', 'Rubiha', 'Rurembo', 'Ryabonyinka', 'Wimana']
    end
  end
  
  # Lists
  
  describe '.provinces' do
    let(:output) { r.provinces }
    
    it 'can list the provinces of Rwanda' do
      expect(output.sort).to eq ["Kigali City", "Western Province", "Northern Province", "Southern Province", "Eastern Province"].sort
    end
  end
  
  describe '.districts' do
    let(:output) { r.districts }
    
    it 'can list the districts of Rwanda' do
      expect(output.sort).to eq ["Nyarugenge", "Gasabo", "Kicukiro", "Nyanza", "Gisagara", "Nyaruguru", "Huye", "Nyamagabe", "Ruhango", "Muhanga", "Kamonyi", "Karongi", "Rutsiro", "Rubavu", "Nyabihu", "Ngororero", "Rusizi", "Nyamasheke", "Rulindo", "Gakenke", "Musanze", "Burera", "Gicumbi", "Rwamagana", "Nyagatare", "Gatsibo", "Kayonza", "Kirehe", "Ngoma", "Bugesera"].sort
    end
  end
  
  describe '.sectors' do
    #let (:output) { r.sectors }
    
      it 'can list the sectors of Rwanda' do
      expect(r.sectors.count).to eq 416
      #expect(r.sectors.sort).to eq SECTORS
      #expect(SECTORS - r.sectors).to eq []
      r.sectors.each_with_index do |s,i|
        expect(s).to eq SECTORS[i]
      end
    end
  end
  
  # Fuzzy Matching
  
  describe '.[division]_like' do
    it 'can offer suggestions for mis-typed provinces' do
      expect(r.province_like('Westrun Provinc')).to eq 'Western Province'
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
    it 'knows whether a division exists' do
      expect(r.is_district? 'Karongi').to eq true
      expect(r.is_sector? 'Gashari').to eq true
      expect(r.is_cell? 'Musasa').to eq true
      expect(r.is_village? 'Kaduha').to eq true
      expect(r.is_district? 'Karoooongi').to eq false
      expect(r.is_sector? 'Gashariii').to eq false
      expect(r.is_cell? 'Musasasasasa').to eq false
      expect(r.is_village? 'Kaduhahaha').to eq false
    end
  end
  
  describe '.is_real' do
    it 'knows whether a chain of divisions is legitimate' do
      expect(r.exist?('Karongi','Bwishyura','Kiniha','Nyarurembo')).to eq true
      expect(r.exist?('Karongi','Bwishyura','Nyarurembo')).to eq false
      expect(r.exist?('Karongi')).to eq true
    end
  end
  #describe '.is_in?' do
  #  it 'knows whether a smaller division is inside a larger division' do
  #    expect(r.is_in?('Karongi','Gashari')).to eq true
  #    expect(r.is_in?('Gashari','Karongi')).to eq false
  #    expect(r.is_in?('
  #  end
  #end
end