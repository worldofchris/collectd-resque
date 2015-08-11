# collectd-resque

Logs [Resque](https://github.com/resque/resque) details to [collectd](https://collectd.org/) via the [Exec plugin](https://collectd.org/wiki/index.php/Plugin:Exec).

## Dependencies

* [Ruby](https://www.ruby-lang.org/en/) 2.1.5
* [Bundler](http://bundler.io/)

## Installation

Clone this repo then run `bundle install`.

Load and configure the Exec Plugin e.g.

	LoadPlugin exec
	<Plugin exec>
	  Exec "my_user:my_group" "/home/my_user/collectd_resque.rb" \
	    "-c" "/path/to/resque/config.yml" \
	    "-e" "production"
	</Plugin>

## Development

### Running the tests

	rspec
