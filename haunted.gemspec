# frozen_string_literal: true

require_relative "lib/haunted/version"

Gem::Specification.new do |spec|
  spec.name = "haunted"
  spec.version = Haunted::VERSION
  spec.authors = ["Dana Holt"]
  spec.email = [""]

  spec.summary = "Ghost CMS Content API client"
  spec.description = "This gem retrieves data from a Ghost CMS through the content API."
  spec.homepage = "https://github.com/DanaHolt/haunted"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = ""

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/DanaHolt/haunted"
  spec.metadata["changelog_uri"] = "https://github.com/DanaHolt/haunted/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.20.0"

  spec.post_install_message = "BOO!"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
