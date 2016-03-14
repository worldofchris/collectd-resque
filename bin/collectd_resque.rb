#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'

require 'yaml'
require 'trollop'

require_relative 'lib/resque_status'

opts = Trollop::options do
  banner <<-EOS
Log Resque details to collectd via the Exec Plugin

Usage:
  collectd-resque.rb [options]
  
where [options] are:
EOS
  
  opt :config_file, "Path to Resque config file", type: :string
  opt :environment, "Environment config to use", type: :string
end

mandatory = [:config_file, :environment]

mandatory.each do |opt|  
  Trollop::die opt, "must be supplied" if opts[opt].nil?
end

Trollop::die :config_file, "#{opts[:config_file]} not found" unless File.exists?(opts[:config_file])
resque_conf = YAML.load_file(opts[:config_file])

Trollop::die :environment, "#{opts[:environment]} not found" unless resque_conf.has_key?(opts[:environment])
ResqueStatus.redis = resque_conf[opts[:environment]]

interval = ENV['COLLECTD_INTERVAL']
hostname = ENV['COLLECTD_HOSTNAME']

while true do
  puts ResqueStatus.to_collectd(hostname)
  sleep interval.to_i
end