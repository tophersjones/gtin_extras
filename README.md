# gtin_extras
Ruby String extensions for validating and formatting GTIN/UPC/EAN/GS1 _and_ PLU _and_ ASIN _and_ ISBN _and_ UNSPSC numbers. Use these to clean up and validate your ecommerce data!

## Usage

```ruby
require 'gtin_extras'

'076308722791'.ean?             # false
'076308722791'.upc?             # true
'10048001693866'.gtin_structure # :gs1
'1a048001693866'.gtin_structure # nil
'76308722791'.coerce_to_upc     # 076308722791
'07630872279'.coerce_to_upc     # 076308722791
'7630872279'.coerce_to_upc      # nil

'3400'.plu?                     # true
'THIS00AN53'.asin?              # true
'960-425-059-0'.isbn?           # true
'960 425 059 0'.isbn?           # true
'9781234567897'.isbn?           # true
'43201501'.unspsc?              # true
'4320150114'.unspsc?            # false
'43201501'.unspsc_title?        #'Asynchronous transfer mode ATM telecommunications interface cards'
'43201511'.unspsc_title?        # 'No results found'


```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gtin_extras'
```

And then execute:

```sh
$ bundle install
```

Or install it yourself as:

```sh
$ gem install gtin_extras
```

## Testing

```sh
$ rspec
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## References

- https://www.gs1.org/services/how-calculate-check-digit-manually
- https://www.gtin.info/check-digit-calculator/
- https://www.amazon.com/gp/seller/asin-upc-isbn-info.html
- https://www.ifpsglobal.com/Identification/PLU-Codes
- https://www.instructables.com/id/How-to-verify-a-ISBN/
- https://en.wikipedia.org/wiki/International_Standard_Book_Number
- 
https://www.unspsc.org/search-code/, https://www.unspsc.org/faqs
- 

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/officeluv/gtin_extras. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.
