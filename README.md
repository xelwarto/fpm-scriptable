# fpm-scriptable

[![GitHub version](https://badge.fury.io/gh/xelwarto%2Ffpm-scriptable.svg)](http://badge.fury.io/gh/xelwarto%2Ffpm-scriptable)
[![Gem Version](https://badge.fury.io/rb/fpm-scriptable.svg)](http://badge.fury.io/rb/fpm-scriptable)

<dl>
  <dt>Author</dt><dd>Ted Elwartowski (<a href="mailto:xelwarto.pub@gmail.com">xelwarto.pub@gmail.com</a>)</dd>
  <dt>Copyright</dt><dd>Copyright © 2014 Ted Elwartowski</dd>
  <dt>License</dt><dd>Apache 2.0 - http://www.apache.org/licenses/LICENSE-2.0</dd>
</dl>

## Description

**fpm-scriptable** provides a simple and easy to use scripting interface for creating software packages with fpm (https://github.com/jordansissel/fpm). Software packages are created using easy to read scripts written in a simple DSL. Scripts can easily be added to source code to ensure they are properly versioned.

Specific package types are provided by **fpm-scriptable** plug-ins. Plug-ins are script extensions which provide specific FPM software packaging.

Current Plug-ins:

* **FPM::Scriptable::RPM** - Support for RPM packaging

## Installation

#### Installation Requirements:

**Installation of required packages on RHEL based systems**
```bash
yum -y groupinstall "Development tools"
yum -y install rpm-build libcurl-devel ruby-devel
```

#### Installation of fpm-scriptable

```bash
gem install fpm-scriptable
```


## Usage

From CLI
```bash
fpm-script --script <script_file>
```

From Ruby
```ruby
require 'rubygems'
require 'fpm/scriptable'

opts = {
  :nobanner => true,
  :nocolor => true,
  :script => 'script.rb',
}
FPM::Scriptable::App.run(opts)
```

## Sample Scripts

Simple script for packaging source code

```ruby
FPM::Scriptable::RPM.build do
  # Package Name
  name 'test-pkg'

  # Package Source 
  srcdir '/path/to/source/directory'

  # Create Package
  create
end
```

Script with multiple source directories

```ruby
FPM::Scriptable::RPM.build do
  # Package Name
  name 'test-pkg'
  
  # Package Version
  version '1.0'
  
  # Package Iteration
  iteration '1'
  
  # Package Description
  description 'Test Package'

  # Package Source
  srcdir '/first/path/to/source/directory'
  srcdir '/second/path/to/source/directory'
  srcdir '/third/path/to/source/directory'

  # Create Package
  create
end
```

Using environment variables to set package information

```ruby
FPM::Scriptable::RPM.build do
  # Package Name
  name 'test-pkg'
  
  # Set Package Version
  env.rpm_version ||= '1.0' 
  version env.rpm_version

  # Set Package Iteration
  env.rpm_iteration ||= '1' 
  iteration env.rpm_iteration

  # Package Source 
  srcdir '/path/to/source/directory'

  # Create Package
  create
end
```

Setting package dependencies

```ruby
FPM::Scriptable::RPM.build do
  # Package Name
  name 'test-pkg'
  
  # Package Version
  version '1.0'

  # Package Source 
  srcdir '/path/to/source/directory'
  
  # Package Dependencies
  depends 'package1'
  depends 'package2 = 1.1.1'
  depends 'package3 >= 1.0'
  
  # Package Replaces
  replaces 'test-pkg*'
  
  # Package Conflicts
  conflicts 'test-pkg2'

  # Create Package
  create
end
```

Setting destination directory

```ruby
FPM::Scriptable::RPM.build do
  # Package Name
  name 'test-pkg'
  
  # Package Version
  version '1.0'

  # Package Source 
  srcdir "#{config.working_dir}/IN"

  # Create Package
  dstdir "#{config.working_dir}/OUT"
  create
end
```

Including scripts in a package

```ruby
FPM::Scriptable::RPM.build do
  # Package Name
  name 'test-pkg'
  
  # Package Version
  version '1.0'

  # Package Source 
  srcdir '/path/to/source/directory'
  
  # Package Scripts
  before_install '/path/to/script/file'
  after_install '/path/to/script/file'
  before_remove '/path/to/script/file'
  after_remove '/path/to/script/file'

  # Create Package
  create
end
```

Excluding files and directories

```ruby
FPM::Scriptable::RPM.build do
  # Package Name
  name 'test-pkg'
  
  # Package Version
  version '1.0'

  # Package Source 
  srcdir '/path/to/source/directory'
  
  # Exclude from Package
  excludes '.git'
  excludes '**.git'

  # Create Package
  create
end
```

Overwrite existing package file

```ruby
FPM::Scriptable::RPM.build do
  # Package Name
  name 'test-pkg'

  # Package Source 
  srcdir '/path/to/source/directory'

  # Overwrite Enabled
  overwrite = 'true'
  
  # Create Package
  create
end
```

Set the FPM working directory

```ruby
FPM::Scriptable::RPM.build do
  # Package Name
  name 'test-pkg'

  # Package Source 
  srcdir '/path/to/source/directory'

  # Set Working Directory
  workdir 'path/to/working/dir'
  
  # Create Package
  create
end
```

Including other RPMs in source - will download and expand RPM in to package source

```ruby
FPM::Scriptable::RPM.build do
  # Package Name
  name 'test-pkg'
  
  # Package Version
  version '1.0'

  # Package Source 
  srcdir '/path/to/source/directory'
  
  # Include RPM
  srcrpm 'http://fedora-epel.mirror.lstn.net/6/i386/epel-release-6-8.noarch.rpm'

  # Create Package
  create
end
```
