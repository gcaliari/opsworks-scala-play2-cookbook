#
# Cookbook Name:: play2
# Recipe:: deploy
#

command "echo '#{node}'"
command "echo '#{node[:opsworks][:applications][:name]}'"
command "echo '#{node[:deploy]}'"
command "echo '#{node.keys}'"
node[:deploy].each do |application, deploy|
  opsworks_play2 do
    app application
    deploy_data deploy
  end
end