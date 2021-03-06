#
# Author:: Matt Ray <matt@opscode.com>
# Cookbook Name:: zenoss
# Attributes:: default
#
# Copyright 2010, Zenoss, Inc
# Copyright 2010, 2011 Opscode, Inc
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

::Chef::Node.send(:include, Opscode::OpenSSL::Password)

#set_unless[:zenoss][:server][:admin_password] = secure_password

default[:zenoss][:device][:device_class]    = "/Discovered" #overwritten by roles or on nodes
default[:zenoss][:device][:location]        = "" #overwritten by roles or on nodes
default[:zenoss][:device][:modeler_plugins] = [] #overwritten by roles or on nodes
default[:zenoss][:device][:properties]      = {} #overwritten by roles or on nodes
default[:zenoss][:device][:templates]       = [] #overwritten by roles or on nodes
default[:zenoss][:server][:version]         = "3.2.1-0"
default[:zenoss][:server][:zenoss_pubkey]   = "" #gets set in the server recipe, read by clients
default[:zenoss][:source][:url]             = "http://192.168.124.10:8091/files/" #file location
  
#Crowbar provides file access from /tftpboot/files

case node['platform']
when "ubuntu","debian"
  default[:zenoss][:server][:zenhome]         = "/usr/local/zenoss/zenoss" #RPM is different
  default[:zenoss][:file][:stack]             = "zenoss-stack_3.2.1_x64.deb"

when "redhat","centos","scientific"
  default[:zenoss][:server][:zenhome]         = "/opt/zenoss" #RPM is different
end

#it might matter that these get ordered eventually
default[:zenoss][:server][:installed_zenpacks] = {
  "ZenPacks.zenoss.DeviceSearch" => "1.0.0",
  "ZenPacks.zenoss.LinuxMonitor"  => "1.1.5",
  "ZenPacks.community.MySQLSSH"  => "0.4",
  "ZenPacks.zenoss.OpenStackSwift" => "0.7.0",
}

#patches from http://dev.zenoss.com/trac/report/6 marked 'closed'
#it might matter that these get ordered eventually as well
default[:zenoss][:server][:zenpatches] = {

}
