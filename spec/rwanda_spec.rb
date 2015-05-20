require 'spec_helper'

# Source: old national statistics document
OLD_SECTORS=['Base', 'Bigogwe', 'Boneza', 'Bugarama', 'Bugeshi', 'Bukure', 'Bumbogo', 'Bungwe', 'Burega', 'Buruhukiro', 'Busanze', 'Busasamana', 'Busasamana', 'Busengo', 'Bushekeri', 'Bushenge', 'Bushoki', 'Busogo', 'Busoro', 'Butare', 'Butaro', 'Buyoga', 'Bweramana', 'Bweyeye', 'Bwira', 'Bwishyura', 'Bwisige', 'Byimana', 'Byumba', 'Coko', 'Cyabakamyi', 'Cyabingo', 'Cyahinda', 'Cyanika', 'Cyanika', 'Cyanzarwe', 'Cyato', 'Cyeru', 'Cyeza', 'Cyinzuzi', 'Cyumba', 'Cyungo', 'Cyuve', 'Fumbwe', 'Gacaca', 'Gacurabwenge', 'Gahanga', 'Gahara', 'Gahengeri', 'Gahini', 'Gahunga', 'Gakenke', 'Gasaka', 'Gasange', 'Gashaki', 'Gashanda', 'Gashenyi', 'Gashonga', 'Gashora', 'Gataraga', 'Gatare', 'Gatebe', 'Gatenga', 'Gatore', 'Gatsata', 'Gatsibo', 'Gatumba', 'Gatunda', 'Gihango', 'Giheke', 'Gihombo', 'Gihundwe', 'Gikomero', 'Gikondo', 'Gikonko', 'Gikundamvura', 'Gisenyi', 'Gishamvu', 'Gishari', 'Gishari', 'Gishubi', 'Gishyita', 'Gisozi', 'Gitambi', 'Gitega', 'Gitesi', 'Giti', 'Gitoki', 'Gitovu', 'Hindiro', 'Huye', 'Jabana', 'Jali', 'Janja', 'Jarama', 'Jenda', 'Jomba', 'Juru', 'Kabacuzi', 'Kabagari', 'Kabare', 'Kabarondo', 'Kabarore', 'Kabatwa', 'Kabaya', 'Kacyiru', 'Kaduha', 'Kagano', 'Kagarama', 'Kageyo', 'Kageyo', 'Kageyo', 'Kagogo', 'Kamabuye', 'Kamegeri', 'Kamembe', 'Kamubuga', 'Kanama', 'Kaniga', 'Kanjongo', 'Kanombe', 'Kansi', 'Kanyinya', 'Kanzenze', 'Karago', 'Karama', 'Karama', 'Karama', 'Karambi', 'Karambo', 'Karangazi', 'Karembo', 'Karenge', 'Karengera', 'Katabagemu', 'Kavumu', 'Kayenzi', 'Kayumbu', 'Kazo', 'Kibangu', 'Kibeho', 'Kibilizi', 'Kibirizi', 'Kibirizi', 'Kibumbwe', 'Kibungo', 'Kicukiro', 'Kigabiro', 'Kigali', 'Kigarama', 'Kigarama', 'Kigembe', 'Kigeyo', 'Kigina', 'Kigoma', 'Kigoma', 'Kimihurura', 'Kimironko', 'Kimisagara', 'Kimonyi', 'Kinazi', 'Kinazi', 'Kinigi', 'Kinihira', 'Kinihira', 'Kinoni', 'Kintobo', 'Kinyababa', 'Kinyinya', 'Kiramuruzi', 'Kirehe', 'Kirimbi', 'Kisaro', 'Kitabi', 'Kivu', 'Kivumu', 'Kivuruga', 'Kivuye', 'Kiyombe', 'Kiyumba', 'Kiziguro', 'Macuba', 'Mageragere', 'Mahama', 'Mahembe', 'Mamba', 'Manihira', 'Manyagiro', 'Maraba', 'Mareba', 'Masaka', 'Masoro', 'Mata', 'Mataba', 'Matimba', 'Matyazo', 'Mayange', 'Mbazi', 'Mbazi', 'Mbogo', 'Mbuye', 'Mimuli', 'Minazi', 'Miyove', 'Mpanga', 'Mubuga', 'Mudende', 'Mugano', 'Muganza', 'Muganza', 'Muganza', 'Mugesera', 'Mugina', 'Mugombwa', 'Mugunga', 'Muhanda', 'Muhanga', 'Muhazi', 'Muhima', 'Muhondo', 'Muhororo', 'Muhoza', 'Muhura', 'Mukama', 'Mukamira', 'Mukarange', 'Mukarange', 'Mukindo', 'Mukingo', 'Muko', 'Muko', 'Mukura', 'Mukura', 'Munini', 'Munyaga', 'Munyiginya', 'Murama', 'Murama', 'Murambi', 'Murambi', 'Murambi', 'Muringa', 'Murunda', 'Murundi', 'Murundi', 'Mururu', 'Musambira', 'Musange', 'Musanze', 'Musasa', 'Musaza', 'Musebeya', 'Musenyi', 'Musha', 'Musha', 'Musheli', 'Mushikiri', 'Mushishiro', 'Mushonyi', 'Mushubati', 'Mushubi', 'Mutenderi', 'Mutete', 'Mutuntu', 'Muyira', 'Muyongwe', 'Muyumbu', 'Muzo', 'Mwendo', 'Mwiri', 'Mwogo', 'Mwulire', 'Nasho', 'Ndaro', 'Ndego', 'Ndera', 'Ndora', 'Nduba', 'Nemba', 'Nemba', 'Ngamba', 'Ngarama', 'Ngera', 'Ngeruka', 'Ngoma', 'Ngoma', 'Ngoma', 'Ngororero', 'Niboye', 'Nkanka', 'Nkomane', 'Nkombo', 'Nkotsi', 'Nkungu', 'Ntarabana', 'Ntarama', 'Ntongwe', 'Ntyazo', 'Nyabimata', 'Nyabinoni', 'Nyabirasi', 'Nyabitekeri', 'Nyagatare', 'Nyagihanga', 'Nyagisozi', 'Nyagisozi', 'Nyakabanda', 'Nyakabuye', 'Nyakarenzo', 'Nyakariro', 'Nyakiliba', 'Nyamabuye', 'Nyamata', 'Nyamirama', 'Nyamirambo', 'Nyamiyaga', 'Nyamiyaga', 'Nyamugali', 'Nyamyumba', 'Nyange', 'Nyange', 'Nyankenke', 'Nyanza', 'Nyarubaka', 'Nyarubuye', 'Nyarugenge', 'Nyarugenge', 'Nyarugunga', 'Nyarusange', 'Nyundo', 'Nzahaha', 'Nzige', 'Rambura', 'Rangiro', 'Remera', 'Remera', 'Remera', 'Remera', 'Rilima', 'Rongi', 'Rubavu', 'Rubaya', 'Rubengera', 'Rubona', 'Rugabano', 'Rugalika', 'Ruganda', 'Rugarama', 'Rugarama', 'Rugendabari', 'Rugengabari', 'Rugera', 'Rugerero', 'Ruhango', 'Ruhango', 'Ruharambuga', 'Ruhashya', 'Ruheru', 'Ruhuha', 'Ruhunde', 'Rukara', 'Rukira', 'Rukoma', 'Rukomo', 'Rukomo', 'Rukozo', 'Rukumberi', 'Ruli', 'Runda', 'Ruramba', 'Ruramira', 'Rurembo', 'Rurenge', 'Rusarabuge', 'Rusasa', 'Rusatira', 'Rusebeya', 'Rusenge', 'Rushaki', 'Rushashi', 'Rusiga', 'Rusororo', 'Rutare', 'Rutunga', 'Ruvune', 'Rwabicuma', 'Rwamiko', 'Rwaniro', 'Rwankuba', 'Rwaza', 'Rwempasha', 'Rwerere', 'Rweru', 'Rwezamenyo', 'Rwimbogo', 'Rwimbogo', 'Rwimiyaga', 'Rwinkwavu', 'Sake', 'Save', 'Shangasha', 'Shangi', 'Shingiro', 'Shyara', 'Shyira', 'Shyogwe', 'Shyorongi', 'Simbi', 'Sovu', 'Tabagwe', 'Tare', 'Tumba', 'Tumba', 'Twumba', 'Uwinkingi', 'Zaza'].sort

# Source: MINALOC via Annoncée
SECTORS=['Base', 'Bigogwe', 'Boneza', 'Bugarama', 'Bugeshi', 'Bukure', 'Bumbogo', 'Bungwe', 'Burega', 'Buruhukiro', 'Busanze', 'Busasamana', 'Busasamana', 'Busengo', 'Bushekeri', 'Bushenge', 'Bushoki', 'Busogo', 'Busoro', 'Butare', 'Butaro', 'Buyoga', 'Bweramana', 'Bweyeye', 'Bwira', 'Bwishyura', 'Bwisige', 'Byimana', 'Byumba', 'Coko', 'Cyabakamyi', 'Cyabingo', 'Cyahinda', 'Cyanika', 'Cyanika', 'Cyanzarwe', 'Cyato', 'Cyeru', 'Cyeza', 'Cyinzuzi', 'Cyumba', 'Cyungo', 'Cyuve', 'Fumbwe', 'Gacaca', 'Gacurabwenge', 'Gahanga', 'Gahara', 'Gahengeri', 'Gahini', 'Gahunga', 'Gakenke', 'Gasaka', 'Gasange', 'Gashaki', 'Gashanda', 'Gashari', 'Gashenyi', 'Gashonga', 'Gashora', 'Gataraga', 'Gatare', 'Gatebe', 'Gatenga', 'Gatore', 'Gatsata', 'Gatsibo', 'Gatumba', 'Gatunda', 'Gihango', 'Giheke', 'Gihombo', 'Gihundwe', 'Gikomero', 'Gikondo', 'Gikonko', 'Gikundamvura', 'Gisenyi', 'Gishali', 'Gishamvu', 'Gishubi', 'Gishyita', 'Gisozi', 'Gitambi', 'Gitega', 'Gitesi', 'Giti', 'Gitoki', 'Gitovu', 'Hindiro', 'Huye', 'Jabana', 'Jali', 'Janja', 'Jarama', 'Jenda', 'Jomba', 'Juru', 'Kabacuzi', 'Kabagali', 'Kabare', 'Kabarondo', 'Kabarore', 'Kabatwa', 'Kabaya', 'Kacyiru', 'Kaduha', 'Kagano', 'Kagarama', 'Kageyo', 'Kageyo', 'Kageyo', 'Kagogo', 'Kamabuye', 'Kamegeri', 'Kamembe', 'Kamubuga', 'Kanama', 'Kaniga', 'Kanjongo', 'Kanombe', 'Kansi', 'Kanyinya', 'Kanzenze', 'Karago', 'Karama', 'Karama', 'Karama', 'Karambi', 'Karambo', 'Karangazi', 'Karembo', 'Karenge', 'Karengera', 'Katabagemu', 'Kavumu', 'Kayenzi', 'Kayumbu', 'Kazo', 'Kibangu', 'Kibeho', 'Kibilizi', 'Kibirizi', 'Kibirizi', 'Kibumbwe', 'Kibungo', 'Kicukiro', 'Kigabiro', 'Kigali', 'Kigarama', 'Kigarama', 'Kigembe', 'Kigeyo', 'Kigina', 'Kigoma', 'Kigoma', 'Kimihurura', 'Kimironko', 'Kimisagara', 'Kimonyi', 'Kinazi', 'Kinazi', 'Kinigi', 'Kinihira', 'Kinihira', 'Kinoni', 'Kintobo', 'Kinyababa', 'Kinyinya', 'Kiramuruzi', 'Kirehe', 'Kirimbi', 'Kisaro', 'Kitabi', 'Kivu', 'Kivumu', 'Kivuruga', 'Kivuye', 'Kiyombe', 'Kiyumba', 'Kiziguro', 'Macuba', 'Mageregere', 'Mahama', 'Mahembe', 'Mamba', 'Manihira', 'Manyagiro', 'Maraba', 'Mareba', 'Masaka', 'Masoro', 'Mata', 'Mataba', 'Matimba', 'Matyazo', 'Mayange', 'Mbazi', 'Mbazi', 'Mbogo', 'Mbuye', 'Mimuri', 'Minazi', 'Miyove', 'Mpanga', 'Mubuga', 'Mudende', 'Mugano', 'Muganza', 'Muganza', 'Muganza', 'Mugesera', 'Mugina', 'Mugombwa', 'Mugunga', 'Muhanda', 'Muhanga', 'Muhazi', 'Muhima', 'Muhondo', 'Muhororo', 'Muhoza', 'Muhura', 'Mukama', 'Mukamira', 'Mukarange', 'Mukarange', 'Mukindo', 'Mukingo', 'Muko', 'Muko', 'Mukura', 'Mukura', 'Munini', 'Munyaga', 'Munyiginya', 'Murama', 'Murama', 'Murambi', 'Murambi', 'Murambi', 'Muringa', 'Murunda', 'Murundi', 'Murundi', 'Mururu', 'Musambira', 'Musange', 'Musanze', 'Musasa', 'Musaza', 'Musebeya', 'Musenyi', 'Musha', 'Musha', 'Musheri', 'Mushikiri', 'Mushishiro', 'Mushonyi', 'Mushubati', 'Mushubi', 'Mutenderi', 'Mutete', 'Mutuntu', 'Muyira', 'Muyongwe', 'Muyumbu', 'Muzo', 'Mwendo', 'Mwiri', 'Mwogo', 'Mwulire', 'Nasho', 'Ndaro', 'Ndego', 'Ndera', 'Ndora', 'Nduba', 'Nemba', 'Nemba', 'Ngamba', 'Ngarama', 'Ngera', 'Ngeruka', 'Ngoma', 'Ngoma', 'Ngoma', 'Ngororero', 'Niboye', 'Nkanka', 'Nkomane', 'Nkombo', 'Nkotsi', 'Nkungu', 'Ntarabana', 'Ntarama', 'Ntongwe', 'Ntyazo', 'Nyabimata', 'Nyabinoni', 'Nyabirasi', 'Nyabitekeri', 'Nyagatare', 'Nyagihanga', 'Nyagisozi', 'Nyagisozi', 'Nyakabanda', 'Nyakabuye', 'Nyakaliro', 'Nyakarenzo', 'Nyakiriba', 'Nyamabuye', 'Nyamata', 'Nyamirama', 'Nyamirambo', 'Nyamiyaga', 'Nyamiyaga', 'Nyamugari', 'Nyamyumba', 'Nyange', 'Nyange', 'Nyankenke', 'Nyanza', 'Nyarubaka', 'Nyarubuye', 'Nyarugenge', 'Nyarugenge', 'Nyarugunga', 'Nyarusange', 'Nyundo', 'Nzahaha', 'Nzige', 'Rambura', 'Rangiro', 'Remera', 'Remera', 'Remera', 'Remera', 'Rilima', 'Rongi', 'Rubavu', 'Rubaya', 'Rubengera', 'Rubona', 'Rugabano', 'Ruganda', 'Rugarama', 'Rugarama', 'Rugarika', 'Rugendabari', 'Rugengabari', 'Rugera', 'Rugerero', 'Ruhango', 'Ruhango', 'Ruharambuga', 'Ruhashya', 'Ruheru', 'Ruhuha', 'Ruhunde', 'Rukara', 'Rukira', 'Rukoma', 'Rukomo', 'Rukomo', 'Rukozo', 'Rukumberi', 'Ruli', 'Runda', 'Ruramba', 'Ruramira', 'Rurembo', 'Rurenge', 'Rusarabuye', 'Rusasa', 'Rusatira', 'Rusebeya', 'Rusenge', 'Rushaki', 'Rushashi', 'Rusiga', 'Rusororo', 'Rutare', 'Rutunga', 'Ruvune', 'Rwabicuma', 'Rwamiko', 'Rwaniro', 'Rwankuba', 'Rwaza', 'Rwempasha', 'Rwerere', 'Rweru', 'Rwezamenyo', 'Rwimbogo', 'Rwimbogo', 'Rwimiyaga', 'Rwinkwavu', 'Sake', 'Save', 'Shangasha', 'Shangi', 'Shingiro', 'Shyara', 'Shyira', 'Shyogwe', 'Shyorongi', 'Simbi', 'Sovu', 'Tabagwe', 'Tare', 'Tumba', 'Tumba', 'Twumba', 'Uwinkingi', 'Zaza'].sort

describe Rwanda do
  r = Rwanda.new
  
  # Singular Ofs
  
  describe '.district_of' do
    it 'knows the distict of a sector' do
      expect(r.district_of('Jali')).to eq 'Gasabo'
      expect(r.district_of('jAlI')).to eq 'Gasabo'
      
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
      expect(r.exist?('karongi')).to eq true

      # .exists? is an acceptable synonym
      expect(r.exists?('Karongi','Bwishyura','Kiniha','Nyarurembo')).to eq true
      expect(r.exists?('karongi')).to eq true
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
      expect(STDOUT).to receive(:puts).with("Rwanda has 1 district, 1 sector, 1 cell, and 0 villages called Ndego:\n  Ndego is a sector in Kayonza\n  Ndego is a cell in Karama, Nyagatare\n  Ndego is a village in Ndego, Karama, Nyagatare\n")
      r.where_is? 'ndego'
      expect(STDOUT).to receive(:puts).with("Rwanda has no divisions called Foobar\n")
      r.where_is? 'Foobar'
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