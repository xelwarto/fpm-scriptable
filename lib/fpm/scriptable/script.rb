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

      def self.attr_handler(*opts)
        opts.each do |opt|
          class_eval %Q{
            def #{opt.to_s}(value=nil)
              value.nil? ? @#{opt.to_s} : @#{opt.to_s} = value
            end
          }
        end
      end

      def self.attr_list_handler(*opts)
        opts.each do |opt|
          class_eval %Q{
            def #{opt.to_s}(*list)
              @#{opt.to_s} ||= []
              @#{opt.to_s} << list
              @#{opt.to_s}.flatten!
              @#{opt.to_s}.uniq!
              @#{opt.to_s}
            end
          }
        end
      end

      attr_handler   :name, :url, :version, :iteration, :description, :dstdir,
                    :category, :arch

      attr_list_handler :depends, :conflicts, :provides, :replaces, :srcdir

      def initialize
        @log              = FPM::Scriptable::Log.instance
        @config           = FPM::Scriptable::Config.instance.config
        c                 = FPM::Scriptable::Constants.instance

        @log.debug 'FPM::Scriptable::RPM - initializing Script'

        @version          = c.script.version
        @iteration        = c.script.iteration
        @description      = c.script.description
        @dstdir           = c.script.dstdir

        plugin_init
      end

      def fpm_obj
        @log.error 'fpm_obj method not implemented in plugin'
      end

      def fpm_convert
        @log.error 'fpm_convert method not implemented in plugin'
      end

      def plugin_init
      end

      def plugin_setup
      end

			def build_inputs
			end

      def create
        begin
          @fpm                = fpm_obj

          @fpm.name           = name
          @fpm.url            = url if !url.nil?
          @fpm.version        = version
          @fpm.iteration      = iteration
          @fpm.category       = category if !category.nil?
          @fpm.description    = description if !description.nil?
          @fpm.architecture   = arch if !arch.nil?

          @fpm.dependencies   += depends
          @fpm.conflicts      += conflicts
          @fpm.provides       += provides
          @fpm.replaces       += replaces

          plugin_setup
					build_inputs

          #@fpm.config_files +=
          #fpm.directories +=
        rescue Exception => e
          log.error "#{e}"
        end

        begin
          f = fpm_convert

          Dir.chdir(@dstdir) do
            f.output(f.to_s)
          end
        rescue Exception => e
          log.error "#{e}"
        end

      end

      def env
        @env ||= EnvHandler.new
      end

      def log
        @log
      end

      def config
        @config
      end

      def self.build(&block)
        self.new.instance_eval(&block)
      end

      def get_binding
        binding
      end

    end

    class EnvHandler

      def handler(name, *opts)
        if !name.nil?
          name = name.to_s
          if ENV.has_key? name
            ENV[name]
          end
        end
      end

      alias method_missing handler

    end
  end
end
