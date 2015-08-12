# collectd-resque

Logs [Resque](https://github.com/resque/resque) details to [collectd](https://collectd.org/) via the [Exec plugin](https://collectd.org/wiki/index.php/Plugin:Exec).

## Dependencies

* [Ruby](https://www.ruby-lang.org/en/) 2.1.5
* [Bundler](http://bundler.io/)

## Installation

Clone this repo then run `bundle install`.

Load and configure the Exec Plugin.

e.g. if you have installed into `/home/my_user/collectd-resque`:

	LoadPlugin exec
	<Plugin exec>
	  Exec "my_user:my_group" "/home/my_user/collectd-resque/collectd_resque.sh" 
	</Plugin>

You'll need to create a wrapper script based on the example `collectd_resque.sh.example`

This is required for collectd to pick up the bundle environment.

## Development

There are [Rspec](http://rspec.info/) tests which can be run in the normal way - i.e. `rspec`