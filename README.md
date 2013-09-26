# force_format

Define the formats your Rails application should respond to within your controllers.
Normally a Rails3 application tries to respond to all kinds of formats (e.g. html, xml, json, ...).
Unfortunately this will raise errors if the template for the given format can not be found.
This is where ```force_format``` joins the game.


## Requirements

```rails (3.2.x)```

(This gem is tested with Rails 3.2.x only, but other versions may work too.)

## Installation

Add this line to your application's Gemfile:

    gem 'force_format'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install force_format

## Usage

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
    
If you want to skip the filter in inherited controllers, use the ```skip_force_format_filter``` method. 
It accepts the same parameters the ```force_format_filter``` methods except ```:for => ...```.


By default ```force_format``` raises an ```ActionController::RoutingError```
if a requested format is not specified via ```:for => []```. It should be easy to
rescue from this exception, for example in your ```application_controller.rb```:

   
    class ApplicationController < ActionController::Base

      rescue_from ActionController::RoutingError, :with => :render_error

      def render_error
        # handle it
      end
    end



## TODO
1. More tests
3. More robust params checking
4. Custom exception


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
