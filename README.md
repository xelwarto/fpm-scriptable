# fpm-scriptable

<dl>
  <dt>Author</dt><dd>Ted Elwartowski (<a href="mailto:xelwarto.pub@gmail.com">xelwarto.pub@gmail.com</a>)</dd>
  <dt>Copyright</dt><dd>Copyright © 2014 Ted Elwartowski</dd>
  <dt>License</dt><dd>Apache 2.0 - http://www.apache.org/licenses/LICENSE-2.0</dd>
</dl>

## Description

**fpm-scriptable** provides a simple and easy to use scripting interface for creating software packages with fpm (https://github.com/jordansissel/fpm). Software packages are created using easy to read scripts written in a simple DSL. Scripts can easily be added to source code to ensure they are properly versioned.

Specific package types are provided by **fpm-scriptable** plug-ins. Plug-ins are script extensions which provide specific FPM software packing.

Current Plugins:

* **FPM::Scriptable::RPM** - Support for RPM packaging

## Installation

Currently a Ruby gem is not available ... source can be cloned and then run bundler to install dependencies.

## Usage

```bash
bin/fpm-script --script <script_file>
```

## Sample Scripts

Simple script for packaging source code

```ruby
FPM::Scriptable::RPM.build do
  # Package Name
  name 'test-pkg'
  
  # Package Version
  version '1.0'

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
  
  env.rpm_version.nil? ?
    rpm_version = '1.0' :
    rpm_version = env.rpm_version
  version rpm_version

  env.rpm_iteration.nil? ?
    rpm_iteration = '1' :
    rpm_iteration = env.rpm_iteration
  iteration rpm_iteration

  # Package Source 
  srcdir '/path/to/source/directory'

  # Create Package
  create
end
```
