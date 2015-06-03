require 'rwanda'
require 'coveralls'

Coveralls.wear!

RSpec.configure do |config|
  config.color = true
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end