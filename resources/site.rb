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

actions        :enable, :disable, :delete
default_action :enable

attribute :name,              :kind_of => String, :name_attribute => true
attribute :timing,            :equal_to => [ :delayed, :immediately ], :default => :delayed, 

attribute :config_file_mode,  :kind_of => String, :default => '644'
attribute :config_file_owner, :kind_of => String, :default => 'root'

attribute :template,          :kind_of => String, :default => "nginx-site.erb"
attribute :template_cookbook, :kind_of => String
attribute :template_is_local, :kind_of => String 
attribute :template_params,   :kind_of => Hash

