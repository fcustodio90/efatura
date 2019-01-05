require 'efatura/version'
require 'efatura/configuration'
require 'efatura/client'

module Efatura
  require 'mechanize'
  require 'rest-client'
  require 'date'
  require 'json'
  # EFATURA SCRAPER GEM. IT USES MECHANIZE TO SIMULATE A LOGIN TO EFATURA WEBSITE
  # IT THEN REDIRECTS TO CONSUMIDOR PAGE IN ORDER TO FETCH THE NECESSARY COOKIES
  # TO BUILD A REST-CLIENT REQUEST WITH COOKIES AS HEADERS
  # EFATURA WEBSITE IS POPULATED WITH AJAX REQUESTS
  # SO THE GOAL IS FETCH THE SAME JSONS THEY USE TO FEED DATA TO THE WEBSITE

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.invoices(from_date, to_date)
    client = Client.new(from_date, to_date)
    Client.new(from_date, to_date).invoices if client.date_valid?(from_date, to_date)
  end
end
