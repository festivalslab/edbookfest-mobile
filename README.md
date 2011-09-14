# Edinburgh International Book Festival mobile website

## What is this?
This is the application behind the [Edinburgh International Book Festival](http://www.edbookfest.co.uk) 2011 [mobile website at m.edbookfest.co.uk](http://m.edbookfest.co.uk) which was developed by [James Newbery](https://github.com/froots) of [Tinned Fruit Ltd](http://tinnedfruit.com). The project originated at [Culture Hack Scotland](http://culturehackscotland.com) and was supported by the [Edinburgh Festivals Innovation Lab](http://festivalslab.com).

## Licence
m.edbookfest.co.uk mobile website application
Copyright &copy; 2011 Edinburgh International Book Festival Ltd

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

## Acknowledgement
If used for the purpose of creating a public website, we ask that - in addition to the requirements of the GNU
GPL - future users of this application include an acknowledgement within the credits or information section of their 
own site as follows:

    This website makes use of technology developed by Tinned Fruit Ltd (www.tinnedfruit.com) for the Edinburgh International 
	Book Festival Ltd (www.edbookfest.co.uk) with the support of the Edinburgh Festivals Innovation Lab	and Culture Hack Scotland.

This credit should also be included as a meta-tag within the `<head>` element of all pages within the site.

This acknowledgement is non-contractual, but it is a condition of licence that the request be distributed verbatim
as part of the original licence terms.

## Contacts
We are keen to see other cultural organisations building on what we've done, and are happy to answer questions and provide
further information if required. In the first instance, please contact admin@edbookfest.co.uk.

If you do find the code useful, we'd love to hear from you. Drop us a note at the Book Festival, via @acoulton or @festivalslab on
twitter, or through the [festivalslab organisation on GitHub](http://github.com/festivalslab)

## Data Sources
The application combines data from a number of sources:

* The Edinburgh International Book Festival programme listings data
* Edinburgh International Book Festival bookshop stock data
* [Amazon Product Advertising API](https://affiliate-program.amazon.co.uk/gp/advertising/api/detail/main.html)
* [Guardian Open Platform Content API](http://www.guardian.co.uk/open-platform)
* [iTunes Search API](http://www.apple.com/itunes/affiliates/resources/documentation/itunes-store-web-service-search-api.html)

All external APIs are open access - with the relevant keys and subject to terms and conditions - and details are available on 
the linked pages above.

### Edinburgh International Book Festival programme listings data
This is a superset of the real-time data provided to the [Edinburgh Festivals Listings API](http://festivalslab.com/api2011/about/) 
which includes meta-data on related authors and books as well as more detailed data on pricing, sponsors, titles and subtitles in
festival-specific format (elements of which are concatenated to fit the cross-festival API data format).

The data is served as a single XML document, protected by standard HTTP Basic Authentication, and the Book Festival are happy to
discuss providing access - subject to acceptable use policy - to other developers and consumers. The XML schema for this document
is provided within the /docs folder of this repository, as is an archive copy of the 2011 XML document for development, testing 
and review purposes. Please note that URLs listed within the document are not guaranteed to be persistent and may become unavailable
over time. Under no circumstances should this data be used other than for experimentation. To discuss access to live data, or other
usage of archive data, contact [Andrew Coulton](https://github.com/acoulton).

### Edinburgh International Book Festival bookshop stock data
This is a feed from the Book Festival's independent Bookshops' stock control system, again provided in XML format and containing
details of every title ordered for stock in the bookshops (which includes backlist titles, and general stock not related to current
events).

It is served in XML format over HTTP, and again the Book Festival is happy to discuss providing access to other users. The XML schema
is provided within the /docs folder of this repository, and as above an archive copy of the 2011 XML document is also available.

## Development

The Edinburgh International Book Festival mobile app is a Ruby on Rails 3.1 application. Installing and setting up for local development follows the standard path for Rails applications.

### Pre-requisites

* [Git](http://git-scm.com/)
* [Ruby 1.9.2](http://www.ruby-lang.org/) - suggest using [RVM](http://beginrescueend.com/) to manage Ruby versions and gemsets
* [RubyGems](http://rubygems.org/)
* [Bundler](http://gembundler.com/) (`gem install bundler`)
* [Chrome WebDriver](http://www.chromium.org/developers/testing/webdriver-for-chrome) for running some Cucumber features

### Installation

The following instructions are for Mac OS X, but should also work for Linux. Windows users may have to be creative.

* Fork / clone this repo using `git clone` (use GitHub's help if you are not familiar with Git)
* `cd edbookfest-mobile`
* At this point, if you have RVM installed, it will prompt you to create a project-specific gemset named 'edbookfest-mobile'.
* From the project root, `bundle install` to install required gems.
* `rake db:migrate` to run database migrations
* To run the application locally, run `foreman start` or `rails server`. You should see a festival calendar when visiting the home page. There will be no data in the application at this point.

### Fake data

There is a basic rake task to create some fake events data, but this does not currently include featured authors or books. Run `rake listings:fake`.

### Programme listings data

If you would like to have access to the EIBF programme listings data feed, please see the above section on obtaining access credentials.

Listings data are consumed over HTTP via a rake task to import and update the database. The task requires the presence of these environment variables:

* `EIBF_FEED_URL` - full URL to the XML events feed
* `EIBF_FEED_USERNAME` - HTTP basic authentication username for feed
* `EIBF_FEED_PASSWORD` - HTTP basic authentication password for feed

`rake listings:import` will create or update event listings, featured authors and featured books from the feed.

### Stock data

Edinburgh International Book Festival bookshop stock data is also available as a feed. Stock data is imported in a separate rake task, and requires the following environment variable:

* `EIBF_STOCK_URL` - full URL to the XML stock feed

`rake stock:import` creates or updates book entries in the local database.

### Gems

Some of the key gems used in the project:

* [Calendar Helper](https://github.com/topfunky/calendar_helper) is used to generate the calendar
* [Nokogiri](http://nokogiri.org/) is used for consuming and parsing XML feeds
* [httparty](http://httparty.rubyforge.org/) is used for consuming JSON api responses
* [Sucker](http://code.papercavalier.com/sucker/) (now [Amazon Product](http://code.papercavalier.com/amazon_product/)) is used to interact with the Amazon Product Advertising API

### Tests

The codebase has good test coverage with [Cucumber](http://cukes.info/) examples driven by [Capybara](https://github.com/jnicklas/capybara), an [RSpec](http://relishapp.com/rspec) suite and [Jasmine](http://pivotal.github.com/jasmine/) examples for JavaScript code. 

Other test tools are used for mocking time ([Delorean](https://github.com/bebanjo/delorean)), recording and replaying external HTTP responses ([VCR](http://relishapp.com/myronmarston/vcr)), mocking HTTP responses ([WebMock](https://github.com/bblimke/webmock) and [Fakeweb](https://github.com/chrisk/fakeweb)) and creating fake data ([Factory Girl](https://github.com/thoughtbot/factory_girl)).

Tests are run in the usual way:

* `rake` will run all Cucumber examples and the RSpec suite
* `rake cucumber` runs just the cucumber examples
* `rake spec` runs just the RSpec suite
* `rake jasmine` or `rake jasmine:ci` will run the Jasmine JavaScript examples
