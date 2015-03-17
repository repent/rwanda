# Rwanda

Access geographic information about Rwanda.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rwanda'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rwanda

## Usage

```ruby
rw = Rwanda.new
rw.provinces
rw.sectors_of 'Gasabo'
rw.district_of 'Giheke'
rw.sector_like 'Rukuma'
```

Cells and villages may follow if I can get hold of the relevant information.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/rwanda/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
