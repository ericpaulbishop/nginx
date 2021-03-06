#
# Cookbook Name:: nginx
# Attributes:: echo
#
# Author:: Danial Pearce (<github@tigris.id.au>)
#
# Copyright 2013, Danial Pearce
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

default['nginx']['echo']['version']        = '0.57'
default['nginx']['echo']['checksum']       = '8467237ca0fae74ca7a32fbd34fc6044df307098415d48068214c9c235695a07'

default['nginx']['echo']['url']            = nil
#default['nginx']['echo']['url']            = "https://github.com/openresty/echo-nginx-module/archive/v#{node['nginx']['echo']['version']}.tar.gz"
