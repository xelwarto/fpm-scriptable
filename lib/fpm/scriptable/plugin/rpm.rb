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

    class RPM < FPM::Scriptable::Script
      TYPE = 'rpm'

      attr_handler :compression, :digest, :user, :group

      attr_list_handler :scrrpm

      def fpm_obj
        FPM::Package::Dir.new
      end

      def fpm_convert
        obj = FPM::Package.types[TYPE]
        @fpm.convert(obj)
      end

      def plugin_init
        @compression  = 'gzip'
        @digest       = 'md5'
        @user         = 'root'
        @group        = 'root'
      end

      def plugin_setup
        @fpm.attributes[:rpm_compression] = @compression
        @fpm.attributes[:rpm_digest]      = @digest
        @fpm.attributes[:rpm_user]        = @user
        @fpm.attributes[:rpm_group]       = @group

        #@fpm.attributes[:rpm_defattrfile] = '-'
        #@fpm.attributes[:rpm_defattrdir] = '-'
      end
    end

  end
end
