#
# Cookbook Name:: nginx
# Recipe:: Passenger
#
# Copyright 2013, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

packages = value_for_platform_family(
  %w(rhel)   => node['nginx']['passenger']['packages']['rhel'],
  %w(fedora)   => node['nginx']['passenger']['packages']['fedora'],
  %w(debian) => node['nginx']['passenger']['packages']['debian']
)

unless packages.empty?
  packages.each do |name|
    package name
  end
end

if node['nginx']['repo_source'] == 'passenger'
  node.default['nginx']['passenger']['root'] = '/usr/lib/ruby/vendor_ruby/phusion_passenger/locations.ini'
  node.default['nginx']['passenger']['ruby'] = '/usr/bin/ruby'
elsif node['languages'].attribute?('ruby')
  node.default['nginx']['passenger']['ruby'] = node['languages']['ruby']['ruby_bin']
  node.default['nginx']['passenger']['root'] = "#{node['languages']['ruby']['gems_dir']}/gems/passenger-#{node['nginx']['passenger']['version']}"
else
  Chef::Log.warn("node['languages']['ruby'] attribute not detected in #{cookbook_name}::#{recipe_name}")
  Chef::Log.warn("Install a Ruby for automatic detection of node['nginx']['passenger'] attributes (root, ruby)")
  Chef::Log.warn('Using default values that may or may not work for this system.')
  node.default['nginx']['passenger']['ruby'] = '/usr/bin/ruby'
  node.default['nginx']['passenger']['root'] = "/usr/lib/ruby/gems/1.8/gems/passenger-#{node['nginx']['passenger']['version']}"
end





gem_package 'rake' if node['nginx']['passenger']['install_rake']


if node['nginx']['passenger']['install_method'] == 'package'
  package node['nginx']['package_name']
  package 'passenger'
elsif node['nginx']['passenger']['install_method'] == 'source'

  gem_package 'passenger' do
    action     :install
    version    node['nginx']['passenger']['version']
    gem_binary node['nginx']['passenger']['gem_binary'] if node['nginx']['passenger']['gem_binary']
  end

  node.run_state['nginx_configure_flags'] =
    node.run_state['nginx_configure_flags'] | ["--add-module=#{node['nginx']['passenger']['root']}/ext/nginx"]

end

template "#{node['nginx']['dir']}/conf.d/passenger.conf" do
  source 'modules/passenger.conf.erb'
  owner  'root'
  group  node['root_group']
  mode   '0644'
  notifies :reload, 'service[nginx]', :delayed
end
