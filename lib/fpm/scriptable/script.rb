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
                    :category, :arch, :license, :epoch, :maintainer, :vendor,
                    :before_install, :after_install, :before_remove, :after_remove

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
          @fpm.license        = license if !license.nil?
          @fpm.epoch          = epoch if !epoch.nil?
          @fpm.maintainer     = maintainer if !maintainer.nil?
          @fpm.vendor         = vendor if !vendor.nil?

          @fpm.dependencies   += depends
          @fpm.conflicts      += conflicts
          @fpm.provides       += provides
          @fpm.replaces       += replaces

          if !before_install.nil?
            @fpm.scripts[:before_install] = expand_script(before_install)
          end

          if !after_install.nil?
            @fpm.scripts[:after_install] = expand_script(after_install)
          end

          if !before_remove.nil?
            @fpm.scripts[:before_remove] = expand_script(before_remove)
          end

          if !after_remove.nil?
            @fpm.scripts[:after_remove] = expand_script(after_remove)
          end

          plugin_setup
          build_inputs

          # TODO
          #@fpm.config_files +=
          #@fpm.directories +=
          #@fom.attributes[:excludes]
        rescue Exception => e
          log.error "#{e}"
        end

        begin
          f = fpm_convert

          Dir.chdir(@dstdir) do
            @log.info "Building package: #{f.to_s}"
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

      private

      def expand_script(file=nil)
        if !file.nil?
          if File.exists? file
            File.read file
          end
        end
      end
    end

    class EnvHandler

      def handler(name, *opts)
        if !name.nil?
          name = name.to_s

          if name =~ /\=\z/
            name.gsub! /\=/, ''
            if opts.size == 1
              name.upcase!
              ENV[name] = opts.first
            end
          else
            if ENV.has_key? name
              ENV[name]
            else
              name.upcase!
              if ENV.has_key? name
                ENV[name]
              end
            end
          end
        end
      end

      alias method_missing handler

    end
  end
end
