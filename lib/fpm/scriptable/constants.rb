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
                    :script,
                    :website

      def initialize
        @name                 = FPM::Scriptable::NAME
        @version              = FPM::Scriptable::VERSION
        @author               = "#{FPM::Scriptable::AUTHOR} #{FPM::Scriptable::EMAIL}"
        @website              = FPM::Scriptable::WEBSITE
        @log_level            = :info

        @script               = ScriptConstants.new
      end

      private

      class ScriptConstants
        attr_accessor :version, :iteration, :description, :dstdir

        def initialize
          @version            = '1.0'
          @iteration          = '1'
          @description        = "Packages built using #{@name} v#{@version}"
          @dstdir             = '.'
        end
      end
    end
  end
end
