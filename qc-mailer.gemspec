# -*- encoding: utf-8 -*-
require File.expand_path('../lib/qc-mailer/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Bradford"]
  gem.email         = ["david@zerobearing.com"]
  gem.description   = %q{Add to a Rails 3.x project to send email in the background using QueueClassic.}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = "https://github.com/zerobearing2/qc-mailer"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "qc-mailer"
  gem.require_paths = ["lib"]
  gem.version       = QC::Mailer::VERSION

  # specify any dependencies here; for example:
  gem.add_runtime_dependency "activesupport",   "~> 3.0"
  gem.add_runtime_dependency "actionmailer",    "~> 3.0"
  gem.add_runtime_dependency "i18n",            "~> 0.6.0"
  gem.add_runtime_dependency "queue_classic",   "~> 2.0.1"

  gem.add_development_dependency "minitest", "~> 3.3.0"
  gem.add_development_dependency "minitest-reporters"
  gem.add_development_dependency 'rake'
  gem.add_development_dependency "pry"
end
