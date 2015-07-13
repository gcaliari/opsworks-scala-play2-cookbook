#
# Cookbook Name:: play2
# Recipe:: setup
#

include_recipe "java"

package 'git'

url               = node[:play2][:url]
version           = node[:play2][:version]
activator_version = node[:play2][:activator_version]
activator_url     = node[:play2][:activator_url]
activator         = node[:play2][:activator]

package "ntp" do
  action :install
  options "-y"
end

program_path  = "play-#{version}/play"
download_path = "#{url}/#{version}/play-#{version}.zip"
play_version  = node[:play2][:version]

if activator
  program_path = "activator-dist-#{activator_version}/activator"
  download_path = "#{activator_url}/#{activator_version}/typesafe-activator-#{activator_version}.zip"
  play_version  = node[:play2][:activator_version]
end

artifact_deploy "play2" do
  version play_version
  artifact_location download_path

  deploy_to node[:play2][:deploy_to] || "/opt/play"
  shared_directories []

  owner "root"
  group "root"

  after_deploy Proc.new {
    link "/usr/bin/play" do
      to "#{release_path}/#{program_path}"
    end
  }

  action :nothing if Chef::Artifact.get_current_deployed_version(deploy_to) == version
end
