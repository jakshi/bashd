# -*- encoding : utf-8 -*-
#
# Cookbook Name:: bashd
# Provider:: default
#
# Copyright 2015, Kostiantyn Lysenko
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

require 'etc'

def whyrun_supported?
  true
end

use_inline_resources

action :install do
  buser = new_resource.user
  buser_home = Etc.getpwnam(new_resource.user).dir

  install_bashd(buser,buser_home)  
end

protected

def install_bashd(user,home)
  # Create dir for bash scriptlets
  directory "#{home}/.bash.d" do
    user user
    group user
    mode 0775
  end

  script = "for include in ~/.bash.d/*.sh; do source ${include} 2>/dev/null; done"

  # Add including the files from that dir
  ruby_block "include_bashd" do
    block do
      rc = Chef::Util::FileEdit.new("#{home}/.bashrc")
      rc.insert_line_if_no_match(/for include in \~\/\.bash\.d/,script)
      rc.write_file
    end
  end
end
