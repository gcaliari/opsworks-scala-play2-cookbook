#
# Cookbook Name:: play2
# Recipe:: deploy
#

node[:deploy].each do |application, deploy|
  opsworks_play2 do
    app_name node[:opsworks][:applications][:name]
    app application
    deploy_data deploy
  end
end