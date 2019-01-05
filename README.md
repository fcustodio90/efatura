# EfaturaScraper

Efatura is a portuguese finance website that you can visit at https://faturas.portaldasfinancas.gov.pt/

Sadly Efatura doesn't provide the portuguese users with a public API for GET REQUESTS. It has webservices that use SOAP but they are only for post requests and are only being used by tax / accounting programs etc to communicate clients invoices and whatnot to portuguese finances.

So this is where EfaturaScraper comes in! efatura website data is populated via AJAX requests that fetch jsons from the backend. The goal of this GEM is to simulate a login in the backend and then fetch those same jsons that efatura uses to populate the app!

Obviously this gem doesn't save any information and its merely used for educational purposes. It is also 100% OPEN SOURCED so feel free to contribute to it or report bugs! 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'efatura_scraper'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install efatura_scraper

## Usage

First step - Initialize a scraper instance. For that you should do :

    EfaturaScraper::EfaturaScraper.new(nif: 'your_nif', password: 'your_password', s_date: 'starting_date', e_date: 'ending_date')

    Demonstration -----> EfaturaScraper::EfaturaScraper.new(nif: '483574834', password: 'FY2X584FGD1P', s_date: '2017-01-01', e_date: '2017-12-30') 

    you can then save it to a variable rocky_balboa = EfaturaScraper::EfaturaScraper.new(nif: '483574834', password: 'FY2X584FGD1P', s_date: '2017-01-01', e_date: '2017-12-30')

    Also make sure that the starting and ending date are both in the same year because that's one of the requirements of efatura json successful requests. And make sure that the format is year-month-day. The gem comes with built in methods that verify if these conditions are met. If they are not mechanize won't even be initialized.

Second Step - Fetch the faturas / invoices
    
    Using the previous example with the rocky_balboa instance just do
    rocky_balboa.faturas

    And that's it! This returns a json parsed with all the invoices issued during the timeframe that you set during the initialize.


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fcustodio90/efatura_scraper. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the EfaturaScraper project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/fcustodio90/efatura_scraper/blob/master/CODE_OF_CONDUCT.md).
