#!/usr/bin/env ruby
# splunkforwarder Cookbook Default Attributes.
#
# Cookbook Name:: splunkforwarder
# Source:: https://github.com/ampledata/cookbook-splunkfowarder
# Author:: Greg Albrecht <mailto:gba@splunk.com>
# Copyright:: Copyright 2012 Splunk, Inc.
# Licnese:: Apache License 2.0.
#


default['splunkforwarder']['download_url'] = 'http://download.splunk.com/releases'
default['splunkforwarder']['build'] = '220630'
default['splunkforwarder']['version'] = '6.1.3'
#default['splunkforwarder']['receiver_host'] = 'server_host'
#default['splunkforwarder']['receiver_host_port'] = 'server_port'