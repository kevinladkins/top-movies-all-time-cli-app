# TopMoviesAllTime

This gem lists the top-grossing movies of all time by US box-office, US box-office adjusted for inflation, and international box-office.

## Installation

I've had a great deal of trouble pushing this gem to rubygems.org. It *should* be possible to install a local version of the gem via the following steps:

1. run `bundle install`
2. run `rake build`
3. run `gem install pkg/top-movies-all-time-0.1.0.gem`

## Usage

If gem is installed, enter `top-movies-all-time` and follow the onscreen prompts.

If gem is not installed, run `bin/top-movies-all-time` and follow the onscreen prompts.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/top_movies_all_time. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
