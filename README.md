# Edinburgh International Book Festival mobile website

## What is this?
This is the application behind the [Edinburgh International Book Festival](http://www.edbookfest.co.uk) 2011 [mobile website at m.edbookfest.co.uk](http://m.edbookfest.co.uk) which was developed by James Newbery of [Tinned Fruit Ltd](http://tinnedfruit.com). The project originated at [Culture Hack Scotland](http://culturehackscotland.com) and was supported by the [Edinburgh Festivals Innovation Lab](http://festivalslab.com).

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

This credit should also be included as a meta-tag within the <head> element of all pages within the site.

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
is provided within the /docs folder of this repository. An archive copy of the 2011 XML document will be added to this repository
in September 2011 for development, testing and review purposes. It is not yet publicly available to avoid stale content issues, but
can be provided on request by [Andrew Coulton](https://github.com/acoulton).

### Edinburgh International Book Festival bookshop stock data
This is a feed from the Book Festival's independent Bookshops' stock control system, again provided in XML format and containing
details of every title ordered for stock in the bookshops (which includes backlist titles, and general stock not related to current
events).

It is served in XML format over HTTP, and again the Book Festival is happy to discuss providing access to other users. The XML schema
is provided within the /docs folder of this repository, and as above an archive copy of the 2011 XML document will be added to the repository
in September 2011.