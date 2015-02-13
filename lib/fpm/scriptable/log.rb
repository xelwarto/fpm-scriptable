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
    class Log
      include Singleton
      attr_accessor :quiet, :color
      attr_reader :has_error

      def initialize
        @quiet = false
        @color = true

        @logger = nil
        @has_error = false
      end

      def show(msg,quiet=@quiet)
        if !msg.nil?
          puts msg unless quiet
        end
      end

      def add(level=:info, color=true, *args)
        l = LogHandler.new(*args)
        l.level = LogHandler.level level
        l.color = color

        if @logger.nil?
          @logger = l
        else
          @logger.extend(LogHandler.broadcast(l))
        end
      end

      def info(msg)
        if !msg.nil?
          if !@logger.nil?
            @logger.info msg
          end
        end
      end

      def warn(msg)
        if !msg.nil?
          if !@logger.nil?
            @logger.warn msg
          end
        end
      end

      def debug(msg)
        if !msg.nil?
          if !@logger.nil?
            @logger.debug msg
          end
        end
      end

      def error(msg)
        @has_error = true
        if !msg.nil?
          if !@logger.nil?
            @logger.error msg
          end
        end
      end

      def fatal(msg)
        @has_error = true
        if !msg.nil?
          if !@logger.nil?
            @logger.fatal msg
          end
        end
      end

      class LogHandler < Logger
        def initialize(*args)
          super
          @formatter = LogFormatter.new
        end

        def color=(c=true)
          @formatter.color = c
        end

        def self.broadcast(logger)
          Module.new do
            define_method(:add) do |*args, &block|
              logger.add(*args, &block)
              super(*args, &block)
            end

            define_method(:<<) do |x|
              logger << x
              super(x)
            end

            define_method(:close) do
              logger.close
              super()
            end

            define_method(:progname=) do |name|
              logger.progname = name
              super(name)
            end

            define_method(:formatter=) do |formatter|
              logger.formatter = formatter
              super(formatter)
            end

            define_method(:level=) do |level|
              logger.level = level
              super(level)
            end
          end
        end

        def self.level(lvl)
          case lvl
            when :info
              Logger::INFO
            when :warn
              Logger::WARN
            when :debug
              Logger::DEBUG
            when :error
              Logger::ERROR
            when :fatal
              Logger::FATAL
            else
              Logger::UNKNOWN
          end
        end

        class LogFormatter < Logger::Formatter
          attr_accessor :color

          def call(severity, timestamp, progname, msg)
            c = get_color severity

            f_severity = sprintf("%-5s", severity.to_s)
            f_time = timestamp.strftime("%Y-%m-%d %H:%M:%S")

            if !@color.nil? && @color
              "\e[#{c}\e[30m[#{f_severity} #{f_time}] #{msg.to_s.strip}\e[0m\n"
            else
              "[#{f_severity} #{f_time}] #{msg.to_s.strip}\n"
            end
          end

          def get_color(c)
            case c
              when 'DEBUG'
                '46m'
              when 'WARN'
                '43m'
              when 'ERROR'
                '41m'
              when 'FATAL'
                '41m'
              else
                '42m'
            end
          end
        end
      end
    end
  end
end
