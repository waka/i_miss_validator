# IMissValidator

This library discover validation that is not defined in the model.  
It will suggest you undefined validations like this.

```
Model: User
  Column: name
    Missing: presence: true
    Missing: length: { maximum: 255 }
  Column: age
    Missing: numericality: { only_integer: true, less_than_or_equal_to: -2147483648, greater_then_or_equal_to: 2147483648 }
  Column: authorized
    Missing: acceptance: true or acceptance: { accept: 'true', 'false' }
  Column: bank_id
    Missing: presence: true
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'i_miss_validator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install i_miss_validator

## Usage

```
$ cd RAILS_APP_ROOT_DIR
$ bundle exec i_miss_validator
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/waka/i_miss_validator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the IMissValidator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/waka/i_miss_validator/blob/master/CODE_OF_CONDUCT.md).
