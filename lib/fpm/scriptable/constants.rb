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
    class Constants
      include Singleton

      attr_accessor :version,
                    :author,
                    :cfg_file,
                    :name,
                    :log_level,
  									:script_version,
                    :script_iteation,
                    :script_description

      def initialize
        @name         				= 'fpm-scriptable'
        @version      				= '1.0'
        @author       				= 'Ted Elwartowski <xelwarto.pub@gmail.com> (2014)'
        @log_level    				= :info

  			@script_version					= '1.0'
  			@script_iteation				= '1'
  			@script_description			= "Packages built using #{@name} v#{@version}"
      end
    end
  end
end
