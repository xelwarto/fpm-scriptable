
$:.push File.expand_path("lib", File.dirname(__FILE__))
require 'fpm/scriptable/version'

Gem::Specification.new do |spec|
  spec.name         = FPM::Scriptable::NAME
  spec.version      = FPM::Scriptable::VERSION
  spec.summary      = 'Scriptable software packaging using FPM'
  spec.description  = "fpm-scriptable provides a simple and easy to use " \
											"scripting interface for creating software packages " \
											"with fpm (https://github.com/jordansissel/fpm). " \
											"Software packages are created using easy to read " \
											"scripts written in a simple DSL. Scripts can easily " \
											"be added to source code to ensure they are properly " \
											"versioned."
  spec.licenses     = ['Apache-2.0']
  spec.platform     = Gem::Platform::RUBY
  spec.authors      = ['Ted Elwartowski']
  spec.email        = ['xelwarto.pub@gmail.com']
  spec.homepage     = 'https://github.com/xelwarto/fpm-scriptable'

  spec.add_dependency 'curb'
  spec.add_dependency 'fpm'

  files = []
  dirs = %w{lib bin}
  dirs.each do |dir|
    files += Dir["#{dir}/**/*"]
  end

  files << "LICENSE"
  spec.files = files
  spec.require_paths << 'lib'
	spec.bindir = 'bin'
  spec.executables << 'fpm-scriptable'
end
