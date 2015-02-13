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
    class App

      def self.run(app_dir)
        @log = FPM::Scriptable::Log.instance
        args = FPM::Scriptable::Util.get_args

        @log.color = false if args[:nocolor]
        @log.quiet = true if args[:quiet] && ( !args[:help] && !args[:h] )
        @log.quiet = true if args[:q] && ( !args[:help] && !args[:h] )

        if !@log.quiet
          level = FPM::Scriptable::Constants.instance.log_level
          level = args[:log_level] if args[:log_level]
          @log.add(level.to_sym, @log.color, STDOUT)
        end

        @log.show FPM::Scriptable::Util.banner

        if args[:help] || args[:h]
          @log.show FPM::Scriptable::Util.usage, false
          exit 0
        end

        cfg = FPM::Scriptable::Config.instance
        @config = cfg.config
        @config.app_dir = app_dir
        @config.working_dir = Dir.getwd

        script = args[:script]
        if script.nil?
          @log.fatal 'FPM::Scriptable::App - No script file was specified'
          @log.show FPM::Scriptable::Util.usage
          exit 1
        else
          if script !~ /^\//
            script = "#{@config.app_dir}/#{script}"

            if !File.exists? script
              script = args[:script]
              script = "#{@config.working_dir}/#{script}"
            end
          end

          @log.debug "FPM::Scriptable::App - Script file path set to: #{script}"
          if File.file? script
            if File.readable? script
              @script_lines = nil
              begin
                @log.debug 'FPM::Scriptable::App - Reading script file'
                s_lines = nil
                File.open(script) do |f|
                  s_lines = f.readlines
                end
                @script_lines = s_lines.join
              rescue Exception => e
                @log.error "FPM::Scriptable::App - #{e}"
              end

              if @script_lines.nil?
                @log.error "FPM::Scriptable::App - Unable to read script file: #{script}"
              else

              @log.debug 'FPM::Scriptable::App - Staring new thread to execute script'
              begin
                Thread.start {
                  eval(@script_lines)
                }.join
              rescue Exception => e
                @log.error "FPM::Scriptable::App - #{e}"
              end

              end
            else
              @log.error "FPM::Scriptable::App - Unable to read script file: #{script}"
            end
          else
            @log.error "FPM::Scriptable::App - Unable to locate script file: #{script}"
          end
        end

        exit 0
      end

   end
 end
end
