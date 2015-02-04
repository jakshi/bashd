name             'bashd'
maintainer       'Kostiantyn Lysenko'
maintainer_email 'gshaud@gmail.com'
license          'apache2'
description      'LWRP for bash.d scriptlets'
long_description 'LWRP that provide resources for managing bash.d scriptlets'
version          '0.2.0'

%w{debian}.each do |os|
  supports os
end
