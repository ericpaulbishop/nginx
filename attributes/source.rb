#
# Cookbook Name:: nginx
# Attributes:: source
#
# Author:: Jamie Winsor (<jamie@vialstudios.com>)
#
# Copyright 2012-2013, Riot Games
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

include_attribute 'nginx::default'


#dl_strategy should be 'repo' or 'tarball'
default['nginx']['source']['dl_strategy'] = 'tarball'  #switch to 'repo' to clone mercurial repo
default['nginx']['source']['repo']        = "http://hg.nginx.org/nginx"
default['nginx']['configure_flags']       = []
default['nginx']['source']['checksum']    = 'b5608c2959d3e7ad09b20fc8f9e5bd4bc87b3bc8ba5936a513c04ed8f1391a18'
default['nginx']['source']['modules']     = %w(
  nginx::http_ssl_module
  nginx::http_gzip_static_module
)
default['nginx']['source']['use_existing_user'] = false



# Attributes below are derived from the ones above
#
# The problem with setting these defaults here is that if you override 
# one of the attributes above in a given recipe
# the attributes derived from the changed original attributes will still
# be as they were if derived from the default values. Thus, set these
# to nil by default, and define them with the original definitions
# from the original attributes in the recipe itself, but only if these
# attributes are still set to nil (not user specified)
#
default['nginx']['source']['version']                 = nil
default['nginx']['source']['prefix']                  = nil
default['nginx']['source']['conf_path']               = nil
default['nginx']['source']['sbin_path']               = nil
default['nginx']['source']['default_configure_flags'] = nil


default['nginx']['source']['tag']                     = nil
default['nginx']['source']['url']                     = nil


# These are the original values for the derived attributes above, commented out
#
#default['nginx']['source']['version']                 = node['nginx']['version']
#default['nginx']['source']['prefix']                  = "/opt/nginx-#{node['nginx']['source']['version']}"
#default['nginx']['source']['conf_path']               = "#{node['nginx']['dir']}/nginx.conf"
#default['nginx']['source']['sbin_path']               = "#{node['nginx']['source']['prefix']}/sbin/nginx"
#default['nginx']['source']['default_configure_flags'] = %W(
#  --prefix=#{node['nginx']['source']['prefix']}
#  --conf-path=#{node['nginx']['dir']}/nginx.conf
#  --sbin-path=#{node['nginx']['source']['sbin_path']}
#)
#
#
#
#default['nginx']['source']['tag']         = "release-#{node['nginx']['source']['version']}"
#default['nginx']['source']['url']         = "http://nginx.org/download/nginx-#{node['nginx']['source']['version']}.tar.gz"




