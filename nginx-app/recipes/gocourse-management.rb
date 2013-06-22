config = "management"

if is_aws()
  deploy_dir = "/srv/www/#{config}/current/public/"
  nginx_extras = ""
  domain_name = node["gocourse"]["domain"]["management"]
else
  deploy_dir = "/vagrant_data/public/"
  domain_name = ""
  nginx_extras = "sendfile off;"
end

default_router = "index.php"

template "/etc/nginx/sites-enabled/#{config}.conf" do
  source "silex.conf.erb"
  mode   "0755"
  owner  node["nginx-app"][:user]
  group  node["nginx-app"][:group]
  variables(
    :php_user => node["php-fpm"][:user],
    :doc_root => deploy_dir,
    :domain_name => domain_name,
    :access_log => 'off',
    :nginx_extra => nginx_extras,
    :default_router => default_router,
    :xhprof_enable => false,
    :upstream => config,
    :database => node["gocourse"]["database"]
  )
  notifies :restart, resources(:service => "nginx"), :delayed
end
