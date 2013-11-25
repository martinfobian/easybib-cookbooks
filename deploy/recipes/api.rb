include_recipe "php-fpm::service"
include_recipe "nginx-app::service"

node['deploy'].each do |application, deploy|

  if application == 'api'
    next unless allow_deploy(application, 'api', 'nginxphpapp')
  end

  if application == 'discover_api'
    next unless allow_deploy(application, 'discover_api', 'nginxphpapp')
  end

  Chef::Log.info("deploy::api - Deployment started.")
  Chef::Log.info("deploy::api - Deploying as user: #{deploy[:user]} and #{deploy[:group]}")

  opsworks_deploy_dir do
    user  deploy["user"]
    group deploy["group"]
    path  deploy["deploy_to"]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  easybib_nginx application do
    template "silex.conf.erb"
    domain_name deploy['domains'].join(' ')
    doc_root 'web'
    notifies :restart, "service[nginx]", :delayed
  end

  service "php-fpm" do
    action :reload
  end

end
