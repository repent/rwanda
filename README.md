# Rwanda

Access geographic information about administrative divisions in Rwanda, i.e. provinces, districts, sectors, cells and villages.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rwanda'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rwanda

Then you can try it on the command line:

    $ pry
    > gem 'rwanda'
    > require 'rwanda'

## Status

[![Gem Version](https://badge.fury.io/rb/rwanda.svg)](http://badge.fury.io/rb/rwanda)
[![Coverage Status](https://coveralls.io/repos/repent/rwanda/badge.svg)](https://coveralls.io/r/repent/rwanda)
[![Build Status](https://travis-ci.org/repent/rwanda.svg?branch=master)](https://travis-ci.org/repent/rwanda)
[![Code Climate](https://codeclimate.com/github/repent/rwanda/badges/gpa.svg)](https://codeclimate.com/github/repent/rwanda)

## Usage

```ruby
pry(main)> rw=Rwanda.instance
=> #<Rwanda:0x007f00ea48cf28 ... >
pry(main)> rw.where_is? 'Gasabo'
Rwanda has 1 district, 0 sectors, 1 cell, and 8 villages called Gasabo:
  Gasabo is a village in Kimaranzara Cell, Rilima Sector, Bugesera District, Eastern Province
  Gasabo is a village in Butiruka Cell, Remera Sector, Gatsibo District, Eastern Province
  Gasabo is a village in Kiyovu Cell, Ndego Sector, Kayonza District, Eastern Province
  Gasabo is a village in Nkondo Cell, Rwinkwavu Sector, Kayonza District, Eastern Province
  Gasabo is a village in Kazizi Cell, Nyamugari Sector, Kirehe District, Eastern Province
  Gasabo is a district in Kigali City
  Gasabo is a cell in Rutunga Sector, Gasabo District, Kigali City
  Gasabo is a village in Nyanza Cell, Gatenga Sector, Kicukiro District, Kigali City
  Gasabo is a village in Kabeza Cell, Kanombe Sector, Kicukiro District, Kigali City
  Gasabo is a village in Kabuguru II Cell, Rwezamenyo Sector, Nyarugenge District, Kigali City
=> nil
pry(main)> rw.provinces
=> ["Eastern Province", "Kigali City", "Northern Province", "Southern Province", "Western Province"]
pry(main)> rw.sectors_of 'Gasabo'
=> ["Bumbogo", "Gatsata", "Gikomero", "Gisozi", "Jabana", "Jali", "Kacyiru", "Kimihurura", "Kimironko", "Kinyinya", "Ndera", "Nduba", "Remera", "Rusororo", "Rutunga"]
pry(main)> rw.district_of 'Giheke'
=> "Rusizi"
pry(main)> rw.district_of 'Busasamana' # returns array if multiple
=> ["Nyanza", "Rubavu"]
pry(main)> rw.sector_like 'Rukuma'
=> "Rukumberi"
pry(main)> rw.is_district? 'Karongi'
=> true
pry(main)> rw.is_sector? 'Gashari'
=> true
pry(main)> rw.is_cell? 'Musasa'
=> true
pry(main)> rw.is_village? 'Kaduha'
=> true
pry(main)> # Rwanda#exist?(district, sector, cell, village)
pry(main)> rw.exist?('Karongi','Bwishyura','Kiniha','Nyarurembo')
=> true
pry(main)> rw.exist?('Karongi','Bwishyura','Nyarurembo')
=> false
```

Geographic information kindly provided by [MINALOC](http://www.minaloc.gov.rw/).  There are some minor spelling differences between this data and other sources available at sector level (I have not had any other source to compare with at cell and village level).  In particular the following sectors seem to have alternative spellings:

| This gem uses | Others may use |
----------------|-----------------
| Gashari       | Gishari        |
| Gishali       | Gishari        |
| Kabagali      | Kabagari       |
| Mageregere    | Mageragere     |
| Mimuri        | Mimuli         |
| Musheri       | Musheli        |
| Nyakaliro     | Nyakariro      |
| Nyakiriba     | Nyakiliba      |
| Nyamugari     | Nyamugali      |
| Rugarika      | Rugalika       |
| Rusarabuye    | Rusarabuge     |

In some cases both spellings will exist, especially at cell and village level.  I haven't attempted to "clean" the data I was given, except for the case.

The province names are all in English (i.e. *Eastern Province* instead of *Iburasirazuba*).

If you are not familiar with this data set, it's worth noting the following features:
 * province and district names are unique
 * sector, cell and village names are often repeated: two sectors in different districts may have the same name, or a sector, cell and village may all have the same name
 * cells and villages may be named after the sectors and cells that they are in
 * at the cell or village level, there may be multiple villages with the same name, differentiated by a number (in roman numerals) e.g. Matimba cell has seven "Umudugudu Wa"s
 * you might find where_is? helpful for inspecting ambiguity: it lists all divisions at all levels that share the name you give it (try `rw.where_is? 'Gatsibo'`)

## Other Sources

To my knowledge, this dataset has not been published by MINALOC.

[NISR](http://www.statistics.gov.rw/) do, however, publish this information in CSV format down to cell level (2148 cells), as part of their [geolocation datasets](http://statistics.gov.rw/geodata).
 
## Contributing

1. Fork it ( https://github.com/repent/rwanda/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
