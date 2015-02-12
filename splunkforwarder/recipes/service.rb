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

host_port = "#{node['splunkforwarder']['receiver_host']}:#{node['splunkforwarder']['receiver_host_port']}"
execute "/opt/splunkforwarder/bin/splunk add forward-server #{host_port} -auth admin:changeme" do
  not_if{ File.exist?("/opt/splunkforwarder/forward-server-#{host_port}") }
end

file "/opt/splunkforwarder/forward-server-#{host_port}" do
  action :touch
end

index_name = node['splunkforwarder']['index_name']
log_file_name = node['splunkforwarder']['log_path'].split("/").last
execute "/opt/splunkforwarder/bin/splunk add monitor #{node['splunkforwarder']['log_path']} -auth admin:changeme -index #{index_name} -check-index true" do
  not_if{ File.exist?("/opt/splunkforwarder/monitoring-#{log_file_name}") }
end

file "/opt/splunkforwarder/monitoring-#{log_file_name}" do
  action :touch
end
