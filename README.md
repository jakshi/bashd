# bashd

* This cookbook provide LWRPs for managing .bash.d snippets for some user.
* Those snthat will be executed on user login, and very useful for setupping user's environment variables, bash prompt and so on stuff.
* Also it allows you to well structure these scripts.

## Features

* resource for create **.bash.d** folder for bash snippets and include all **.sh** files from the folder with include command in **.bashrc** file. It adds that include command to the **.bashrc** file.
* resource for create and delete those bash snippets from templates.

## Requirements

### Platform

* Tested on Debian 7

<a name="attributes">
## Attributes
<table>
  <tr>
    <th>Attribute</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>snippet</tt></td>
    <td>String</td>
    <td>Snippet name, and at the same time .sh.erb template name (if template source isn't specified)</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>user</tt></td>
    <td>String</td>
    <td>User who will get .bash.d snippets</td>
    <td><tt>root</tt></td>
  </tr>
  <tr>
    <td><tt>cookbook</tt></td>
    <td>String</td>
    <td>Cookbook that contain snippet's erb template</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>source</tt></td>
    <td>String</td>
    <td>snippet's erb template name</td>
    <td><tt>nil</tt></td>
  </tr>
  <tr>
    <td><tt>variables</tt></td>
    <td>Hash</td>
    <td>Hash with variables that should be passed to snippets template</td>
    <td><tt>{}</tt></td>
  </tr>
</table>

## Usage
Add bashd cookbook to your metadata.rb dependency, like:

```
depends 'bashd', '~> 0.0.2'
```

#### Install bashd
Add to recipe:

bashd 'username'

This will:

* create `username_home_dir_from_passwd_file/.bash.d` folder
* Add directive to **.bash.rc** file to include any .sh file from ~/.bash.d folder

When no user specified, this will happen to root (default user).
 
#### Create snippet
To create new snippet:

* create erb template for snippet
* if it has **snippet_name.sh.erb** (snippet_name same as snippet attribute) name it will be used automagically
* if it has **anyothername.erb** name it need to be specified in template attribute

Add to your recipe:

bashd_entry 'snippet_name' do
  user 'username'
  action :create
end

This will create **~/.bash.d/snippet_name.sh** snippet in **~/.bash.d** dir, from snippet_name.sh.erb template.

#### Delete snippet
Add to your recipe:

bashd_entry 'snippet_name' do
  user 'username'
  action :remove
end

This will remove **~/.bash.d/snippet_name.sh** snippet for user username.

## Tests
Integration tests can be runned via Test Kitchen. 

The default .kitchen.yml assumes that you are testing using the vagrant driver, but if you have AWS or DigitalOcean account, you can change the driver and run the tests on remote hosts. To run the tests, exec:

    bundle install
    bundle exec kitchen verify

## Contributing
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Commit your changes (`git commit -am 'Added some feature'`)
7. Push to the branch (`git push origin my-new-feature`)
8. Create new Pull Request

License and Authors
-------------------
Author:: Kostiantyn Lysenko (<gshaud@gmail.com>)

Copyright 2015, Kostiantyn Lysenko

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.