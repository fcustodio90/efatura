# Efatura Gem

Efatura is a portuguese finance/tax website that you can visit at https://faturas.portaldasfinancas.gov.pt/

Currently Efatura doesn't provide a basic REST Api for GET Requests in order to retrieve your personal invoice information during a certain period.

So this is where Efatura Gem comes in.

Efatura website data is populated via AJAX Requests. This gem uses mechanize in order to login to efatura from the backend and intercept the jsons that are being used by AJAX.

This gem is 100% Open sourced and no sensitive information is saved whatsoever so you can use it without any concern.

Feel feel to contribute to it or report any bugs.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'efatura'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install efatura

## How to use - Step by Step

1- Configuration

Start by configurating the Gem.

  For that you should do:

    Efatura.configuration.nif = 'your nif'
    Efatura.configuration.password = 'your password'

  Be sure that you set both configurations as strings.

  You can check if the values are set by doing:

    Efatura.configuration

  This should return an object of Efatura with nif and password set

  Also this gem comes with reset options for configuration. If you wish to reset the nif and password you should do:

    Efatura.reset

  And that's it. if you type:

    Efatura.configuration => you'll see that nif and password are set as nil again.


2- Fetching the invoices

After doing the configuration you are now able to retrieve the invoices between 2 date periods.

  In order to do this type:

    Efatura.invoices(from_date, to_date)

  Make sure that you pass both arguments as strings and also with the correct date format. YEAR-MONTH-DATE example: '2017-01-01'

  If you type the wrong format or wrong date you won't be able to retrieve any information. Also since we are sending a request to an efatura backend there's some validations that we can't avoid. So far i've detected that in order for the gem to retrieve the invoices both dates should be in the same YEAR!

  This is very important as it will not work if you send 

    Efatura.invoices('2017-01-02', '2018-12-02')


And that's pretty much it. Hope you enjoy!


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fcustodio90/efatura. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Efatura project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fcustodio90/efatura/blob/master/CODE_OF_CONDUCT.md).
