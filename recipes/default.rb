#
# Cookbook Name:: cumulus-switch
# Recipe:: default
#
# Copyright 2015, DreamHost
# Copyright 2015, Cumulus Networks
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

include_recipe 'cumulus-switch::switchd'
include_recipe 'cumulus-switch::interfaces'

# Notifying the networking service to reload doesn't work
# for some reason ('up to date'), so we're getting the
# desired results by notifying this instead
execute 'reload_networking' do
  command 'service networking reload'
  action :nothing
end

# service networking reload does not clear any old loopback
# addresses.  We must ifdown & ifup the lo interface.
execute 'reload_loopback' do
  command 'ifdown lo && ifup lo'
  action :nothing
end
