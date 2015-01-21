# -*- encoding : utf-8 -*-
name             'bashd-test-helper'
maintainer       'Kostiantyn Lysenko'
maintainer_email 'gshaud@gmail.com'
license          'Apache 2.0'
description      'Cookbook for testing bashd LWRP'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

recipe 'default', 'calls bashd LWRP for testing purposes'

%w{ ubuntu debian }.each do |os|
  supports os
end

depends 'bashd'
