# force_format

[![Gem Version](https://badge.fury.io/rb/force_format.png)](http://badge.fury.io/rb/force_format)
[![Build Status](https://travis-ci.org/marcusg/force_format.png?branch=master)](https://travis-ci.org/marcusg/force_format)
[![Code Climate](https://codeclimate.com/github/marcusg/force_format.png)](https://codeclimate.com/github/marcusg/force_format)
[![Dependency Status](https://gemnasium.com/marcusg/force_format.png)](https://gemnasium.com/marcusg/force_format)

Define  the formats your Rails application should respond to within your controllers.

## Background

Normally a Rails3 application tries to respond to all kinds of formats (e.g. html, xml, json, ...)
defined via ```respond_to``` inside the controller. Given the following setup for a controller responding
to html and javascript requests.

    class PagesController < ApplicationController

      def index
        respond_to do |format|
          format.html
          format.js
        end
      end
    end

All other requests will return a white page with status code 406 (Not Acceptable). FOr some this seems to be a correct behaviour but it may be important for some webapps to render out a error page giving a good description of the error - like 404 pages. In other words: if the action can't handle the requested format render out an error page with an supported format like html.

This is where ```force_format``` joins the game. The gem adds some accessible methods for your controllers based on before_filters. With that you can define the allowed formats for each controller action. If the requested mime-type does not
match one of the specified formats, ```force_format``` will raise a custom exception wich you can handle on you own (e.g. print out some useful sentences for your users).

Besides this, if you theoretical don't need the ```respond_to``` because you use templates which are rendered by default, you can omit the ```respond_to``` block when using ```force_format```.

## Requirements

```rails >= 3.2```

## Installation

Add this line to your application's Gemfile:

    gem 'force_format'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install force_format

## Usage

#### Basics

Include the ```force_format_filter``` method in your controllers.
The important param is the ```:for => [:my, :formats]```.
With that given array of fomat types you can define the formats the
action should respond to (and hopefully find a template).
In addition it accepts ```:only => ...```, ```:except => ...```, ```:if => ...```
and ```:unless => ...``` parameters like the Rails filters.



    class PagesController < ApplicationController
      force_format_filter :for => [:html, :js], :only => :index

      def index
      end
    end


#### Supported format types
For the moment the following (MIME-)types are available.

    ForceFormat::Controller::FORCE_FORMAT_TYPES
    => [:html, :js, :json, :pdf, :csv, :zip, :xml]


#### Skip the filter

If you want to skip the filter in inherited controllers, use the ```skip_force_format_filter``` method.
It accepts the same parameters the ```force_format_filter``` methods except ```:for => ...```.

#### And more options...

Maybe you want to define the formats more granular, for example different per action.
To accomplish this, pass an hash with action names and required formats. Add a *:default* key with formats
for actions that are not specified directly.


    class PagesController < ApplicationController
      force_format_filter :for => {:index => :js, :default => [:json, :html]}

      def index
        # should respond with js
      end

      def new
        # should respond with json or html
      end

    end


#### Handling exceptions

By default ```force_format``` raises an ```ForceFormat::Errors::UnknownFormat```
if a requested format matches none of the attributes specified via ```:for => ...```.
It should be easy to rescue from this exception, for example in your ```application_controller.rb```:


    class ApplicationController < ActionController::Base

      rescue_from ForceFormat::Errors::UnknownFormat, :with => :render_error

      def render_error
        # handle it
      end
    end

#### Use custom exception

You can pass an custom exception lambda to the ```force_format_filter``` method for a better error handling.

    class PagesController < ApplicationController
      force_format_filter :for => :html, :exception => lambda { |msg| raise(MyApp::AwesomeException.new(msg)) }
    end


#### Widcard accept header

If an user agent sets the accept header wildcard like ```*/*``` ```force_format_filter``` would fallback
and set the ```request.format``` to *:html*. This is important for access via ```curl``` and I think for the
google bot too. If you don't want this behaviour of wildcard rewriting you can set the ```:skip_wildcard``` option.

    class PagesController < ApplicationController
      force_format_filter :for => :html, :skip_wildcard => true
    end

NOTE: Call the method ```force_format_filter``` only once per controller!
If you call it multiple times, the last one would be used.


## TODO
1. More tests
2. More robust params checking


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
