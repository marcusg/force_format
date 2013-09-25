# force_format

Define the formats your Rails application should respond to. 
Normally a Rails3 application tries to respond to all kinds of formats (e.g. html, xml, json, ...). 
Unfortunately this will raise Errors if the template for the given format can not be found. 
This is where ```force_format``` joins the game...

## Installation

Add this line to your application's Gemfile:

    gem 'force_format'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install force_format

## Usage

Include the ```force_format_filter``` method in your controllers. 
The important param is the ```:for => [:my, :formats]```
In addition it accepts ```:only => ...```, ```:except => ...```, ```:if => ...``` 
and ```:unless => ...``` parameters like the Rails filters. 

    ```
    class PagesController < ApplicationController
      force_format_filter :for => [:html, :js], :only => :index
      
      def index
      end
    end
    
    ```
    
By default ```force_format``` raises an ```ActionController::RoutingError``` 
if a requested format is not specified via ```:for => []```. It should be easy to 
rescue from this exception, for example in your ```application_controller.rb```:

    ```
    class ApplicationController < ActionController::Base

      rescue_from ActionController::RoutingError, :with => :render_error
      
      def render_error
        # handle it
      end
    end
    
    ```


## TODO
1. more tests
2. ability to skip before filters


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
