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
require 'bundler/setup'
require 'singleton'
require 'logger'
require 'fpm'
require 'curb'

module FPM
	module Scriptable
		# Core classes
		autoload :App, "fpm/scriptable/app"
		autoload :Config, "fpm/scriptable/config"
		autoload :Log, "fpm/scriptable/log"
		autoload :Util, "fpm/scriptable/util"
		autoload :Constants, "fpm/scriptable/constants"
		autoload :Script, "fpm/scriptable/script"

		# Package type plugins
		autoload :RPM, "fpm/scriptable/plugin/rpm"
	end
end
