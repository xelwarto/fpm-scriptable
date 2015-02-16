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
    class Config
      include Singleton

      def initialize
        @log = FPM::Scriptable::Log.instance
        @log.debug 'FPM::Scriptable::Config - Initializing Application Configuration'
      end

      def config
        @config ||= GeneralConfig.new
      end

      protected

      class GeneralConfig

        def initialize
          @u_defined      = {}
        end

        def udefine(name, *opts)
          if !name.nil?
            name = name.to_s
            if name =~ /\=\z/
              name.gsub! /\=/, ''
              if opts.size == 1
                @u_defined[name.to_sym] = opts.first
              end
            else
              @u_defined[name.to_sym]
            end
          end
        end
        alias method_missing udefine
      end

    end
  end
end
