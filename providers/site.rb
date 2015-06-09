#
# Cookbook Name:: nginx
# Definition:: nginx_site
#
# Author:: AJ Christensen <aj@junglist.gen.nz>
#
# Copyright 2008-2013, Chef Software, Inc.
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

def whyrun_supported?
  true
end

action :enable do

  tc = new_resource.template ? new_resource.template_cookbook : "nginx"
  t  = new_resource.template ? new_resource.template : "nginx-site.erb"
  
  template "#{node['nginx']['dir']}/sites-available/#{new_resource.name}" do
    source     t
    cookbook   tc if tc
    local      new_resource.template_is_local  if new_resource.template_is_local
    mode       new_resource.config_file_mode
    owner      new_resource.config_file_owner
    variables( :params => new_resource.template_params )
    only_if    { new_resource.template_params }
  end

  execute "nxensite #{new_resource.name}" do
    command "#{node['nginx']['script_dir']}/nxensite #{new_resource.name}"
    notifies :reload, 'service[nginx]', new_resource.timing
    not_if do
      ::File.symlink?("#{node['nginx']['dir']}/sites-enabled/#{new_resource.name}") ||
        ::File.symlink?("#{node['nginx']['dir']}/sites-enabled/000-#{new_resource.name}")
    end
  end
  
end

action :disable do 
  
  tc = new_resource.template ? new_resource.template_cookbook : "nginx"
  t  = new_resource.template ? new_resource.template : "nginx-site.erb"
  
  template "#{node['nginx']['dir']}/sites-available/#{new_resource.name}" do
    source     t
    cookbook   tc if tc
    local      new_resource.template_is_local  if new_resource.template_is_local
    mode       new_resource.config_config_file_mode
    owner      new_resource.config_config_file_owner
    variables( :params => new_resource.template_params )
    only_if    { new_resource.template_params }
  end
  
  execute "nxdissite #{new_resource.name}" do
    command "#{node['nginx']['script_dir']}/nxdissite #{new_resource.name}"
    notifies :reload, 'service[nginx]', new_resource.timing
    only_if do
      ::File.symlink?("#{node['nginx']['dir']}/sites-enabled/#{new_resource.name}") ||
        ::File.symlink?("#{node['nginx']['dir']}/sites-enabled/000-#{new_resource.name}")
    end
  end


end

action :delete do
    execute "nxdissite #{new_resource.name}" do
    command "#{node['nginx']['script_dir']}/nxdissite #{new_resource.name}"
    notifies :reload, 'service[nginx]', new_resource.timing
    only_if do
      ::File.symlink?("#{node['nginx']['dir']}/sites-enabled/#{new_resource.name}") ||
        ::File.symlink?("#{node['nginx']['dir']}/sites-enabled/000-#{new_resource.name}")
    end
  end

  file "#{node['nginx']['dir']}/sites-available/#{new_resource.name}" do
    action :delete
  end

end

