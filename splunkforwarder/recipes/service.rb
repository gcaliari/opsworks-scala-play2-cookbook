#!/usr/bin/env ruby
# Configures & starts splunkforwarder Service.
#
# Recipe:: service
# Cookbook Name:: splunkstorm
# Source:: https://github.com/ampledata/cookbook-splunkforwarder
# Author:: Greg Albrecht <mailto:gba@splunk.com>
# Copyright:: Copyright 2012 Splunk, Inc.
# License:: Apache License 2.0
#


execute '/opt/splunkforwarder/bin/splunk enable boot-start --accept-license' +
    ' --answer-yes' do
  not_if{ File.symlink?('/etc/rc4.d/S20splunk') }
end

execute '/opt/splunkforwarder/bin/splunk install' +
  'app /opt/splunkforwarder/stormforwarder_91dd83d0927411e3b36f123139097a14.spl' +
  '-auth admin:changeme'

service 'splunk' do
  action [:start]
  supports :status => true, :start => true, :stop => true, :restart => true
end
