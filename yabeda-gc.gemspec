# frozen_string_literal: true

require_relative "lib/yabeda/gc/version"

Gem::Specification.new do |spec|
  spec.name          = "yabeda-gc"
  spec.version       = Yabeda::GC::VERSION
  spec.authors       = ["Ian Ker-Seymer"]
  spec.email         = ["i.kerseymer@gmail.com"]

  spec.summary       = "Extensible Prometheus exporter for monitoring Ruby gargage collection"
  spec.description   = "Prometheus exporter for easy collecting of Ruby GC metrics"
  spec.homepage      = "https://github.com/ianks/yabeda-gc"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "yabeda", "~> 0.6"
  spec.metadata["rubygems_mfa_required"] = "true"
end
