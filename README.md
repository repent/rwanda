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

## Usage

```ruby
rw = Rwanda.new
rw.where_is? 'Gasabo'
rw.provinces
rw.sectors_of 'Gasabo'
rw.district_of 'Giheke'
rw.sector_like 'Rukuma'
rw.is_district? 'Karongi'
rw.is_sector? 'Gashari'
rw.is_cell? 'Musasa'
rw.is_village? 'Kaduha'
# Rwanda#exist?(district, sector, cell, village)
rw.exist?('Karongi','Bwishyura','Kiniha','Nyarurembo')
rw.exist?('Karongi','Bwishyura','Nyarurembo')
```

Geographic information kindly provided by MINALOC.  There are some minor spelling differences between this data and other sources available at sector level (I have not had any other source to compare with at cell and village level).  In particular the following sectors seem to have alternative spellings:

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
 * you might find where_is? helpful for inspecting ambiguity: it lists all divisions at all levels that share the name you give it (try "rw.where_is? 'Gatsibo'")

## Contributing

1. Fork it ( https://github.com/repent/rwanda/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
