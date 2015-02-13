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
    class Util

      def self.get_args
        args = Hash.new
        cur_argv = String.new

        if ARGV.length > 0
          ARGV.each do |x|
            if x =~ /^-/
              cur_argv = x.sub(/^-+/,'')
              if cur_argv != ''
                args[cur_argv.to_sym] = ''
              end
            else
              if cur_argv != ''
                if args[cur_argv.to_sym].instance_of? Array
                  args[cur_argv.to_sym].push x
                else
                  if args[cur_argv.to_sym] != ''
                    cur_value = args[cur_argv.to_sym]
                    args[cur_argv.to_sym] = Array.new
                    args[cur_argv.to_sym].push cur_value
                    args[cur_argv.to_sym].push x
                  else
                    args[cur_argv.to_sym] = x
                  end
                end

              end
            end
          end
        end
        args
      end

      def self.usage
        usage = <<EOF
Usage:
  #{$0} OPTIONS

  Options:
    --help                  Display this help screen
    --quiet                 Messages are not displayed to the console
    --nocolor               Turn off colors in console output
    --log_level <lvl>       STDOUT log level (info, debug, error)

    --script <file>         Script to build

EOF
        usage
      end

      def self.banner
        c = FPM::Scriptable::Constants.instance
        banner = <<EOF

   __                                     _       _        _     _
  / _|_ __  _ __ ___        ___  ___ _ __(_)_ __ | |_ __ _| |__ | | ___
 | |_| '_ \\| '_ ` _ \\ _____/ __|/ __| '__| | '_ \\| __/ _` | '_ \\| |/ _ \\
 |  _| |_) | | | | | |_____\\__ \\ (__| |  | | |_) | || (_| | |_) | |  __/
 |_| | .__/|_| |_| |_|     |___/\\___|_|  |_| .__/ \\__\\__,_|_.__/|_|\\___|
     |_|                                   |_|

 #{c.name}
 Version: #{c.version}
 Author:  #{c.author}
 Website: #{c.website}

EOF
        banner
      end

    end
  end
end
