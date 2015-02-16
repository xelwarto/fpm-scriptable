# Copyright 2014 Ted Elwartowski <xelwarto.pub@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'rubygems'
require 'singleton'
require 'logger'
require 'fpm'
require 'curb'

require 'fpm/scriptable/version'
require 'fpm/scriptable/app'
require 'fpm/scriptable/config'
require 'fpm/scriptable/log'
require 'fpm/scriptable/util'
require 'fpm/scriptable/constants'
require 'fpm/scriptable/script'

# Package type plugins
require 'fpm/scriptable/plugin/rpm'
