#!/usr/bin/env ruby

require 'bundler/setup'
Bundler.require(:default, :development)

require_relative 'lib/config.rb'

opts = Trollop::options do
  opt :priority, "Priority", :type => :string, :default => 'normal'
  opt :application, "Application", :type => :string, :required => true
  opt :event, "Event", :type => :string, :required => true
end

begin
  priority = NMA::Priority::const_get(opts[:priority].upcase)
rescue NameError
  Trollop::die :priority, "must be one of normal, high or emergency"
end

puts "Please enter your message and hit CRTL-D when finished.\n" if $stdin.tty?
description = ARGF.read.strip!

NMA.notify do |n| 
  n.apikey = $CONFIG['api_key']
  n.priority = priority
  n.application = opts[:application]
  n.event = opts[:event]
  n.description = description
end
