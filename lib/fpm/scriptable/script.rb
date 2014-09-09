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

module FPM
	module Scriptable
		class Script

			attr_accessor :name, :version, :iteration, :description

			def initialize
				@log 							= FPM::Scriptable::Log.instance
				@config 					= FPM::Scriptable::Config.instance.config
				c 								= FPM::Scriptable::Constants.instance

				@log.debug 'FPM::Scriptable::RPM - initializing Script'

				@version					= c.script.version
				@iteration				= c.script.iteration
				@description			= c.script.description
			end

			def log
				@log
			end

			def config
				@config
			end

			def self.build(&block)
				RPM.new.instance_eval(&block)
			end

			def get_binding
				binding
			end

			def name(value=nil)
				@name = value
			end

		end
	end
end
