# for some reason, most VMs fail with outdated package lists
execute "aptitude update" do
  command "aptitude update"
end

#execute "update gems" do
#  command "gem update -B 10 --no-rdoc --no-test --no-ri"
#end
