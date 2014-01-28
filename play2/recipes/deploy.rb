#
# Cookbook Name:: play2
# Recipe:: deploy
#

node[:deploy].each do |application, deploy|
  opsworks_play2 do
  	println("----------------------------------------------------")
  	println(node[:opsworks][:applications])
#     app_name node[:opsworks][:applications].filter(ops_app => ops_app[:slug_name] == application)[0][:name]
    app application
    deploy_data deploy
  end
end