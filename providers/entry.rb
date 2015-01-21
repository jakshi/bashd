# -*- encoding : utf-8 -*-
#
# Cookbook Name:: bashd
# Provider:: entry
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

action :create do
  buser = new_resource.user
  buser_home = Etc.getpwnam(new_resource.user).dir

  bashd_install = bashd new_resource.user
  bashd_install.run_action(:install)
  
  template "#{buser_home}/.bash.d/#{new_resource.snippet}.sh" do
    cookbook new_resource.cookbook if new_resource.cookbook
    source new_resource.template if new_resource.template
    mode 0755
    user buser
    group buser
    variables(new_resource.variables)
  end  
end

action :remove do
  buser = new_resource.user
  buser_home = Etc.getpwnam(new_resource.user).dir

  file "#{buser_home}/.bash.d/#{new_resource.snippet}.sh" do
    action :delete
  end
end
