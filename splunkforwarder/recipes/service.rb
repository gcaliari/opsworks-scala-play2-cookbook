#!/usr/bin/env ruby
# Configures & starts splunkforwarder Service.
#
# Recipe:: service
# Cookbook Name:: splunkstorm
# Source:: https://github.com/ampledata/cookbook-splunkforwarder
# Author:: Greg Albrecht <mailto:gba@splunk.com>
# Copyright:: Copyright 2012 Splunk, Inc.
# License:: Apache License 2.0

execute '/opt/splunkforwarder/bin/splunk enable boot-start --accept-license' +
    ' --answer-yes' do
  not_if{ File.symlink?('/etc/rc4.d/S20splunk') }
end

# removing old pointers
execute 'rm -rf /opt/splunkforwarder/var/lib/splunk/fishbucket'

service 'splunk' do
  action [:restart]
  supports :status => true, :start => true, :stop => true, :restart => true
end

remote_file "/opt/splunkforwarder/app.spl" do
  source node['splunkforwarder']['spl_app_url']
  action :create
end

execute '/opt/splunkforwarder/bin/splunk install app /opt/splunkforwarder/app.spl -auth admin:changeme -update 1'

log_file_name = node['splunkforwarder']['log_path'].split("/").last
execute "/opt/splunkforwarder/bin/splunk add monitor #{node['splunkforwarder']['log_path']}" do
  not_if{ File.exist?("/opt/splunkforwarder/monitoring-#{log_file_name}") }
end

file "/opt/splunkforwarder/monitoring-#{log_file_name}" do
  action :touch
end
