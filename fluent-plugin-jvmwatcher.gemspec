# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "fluent-plugin-jvmwatcher"
  gem.version       = "0.1.3"
  gem.authors       = ["MasayukiMiyake"]
  gem.email         = ["masayukimiyake97@gmail.com"]
  gem.description   = %q{It is the input plugin of fluentd which collects the condition of Java VM.}
  gem.summary       = %q{It is the input plugin of fluentd which collects the condition of Java VM.}
  gem.homepage      = "https://github.com/MasayukiMiyake97/fluent-plugin-jvmwatcher.git"

  gem.rubyforge_project = "fluent-plugin-jvmwatcher"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rake"
  gem.add_runtime_dependency "fluentd"	

end
