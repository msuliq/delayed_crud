# frozen_string_literal: true

require_relative "lib/delayed_crud/version"

Gem::Specification.new do |spec|
  spec.name = "delayed_crud"
  spec.version = DelayedCrud::VERSION
  spec.authors = ["Suleyman Musayev"]
  spec.email = ["slmusayev@gmail.com"]

  spec.summary = "The `delayed_crud` gem provides method to perform database CRUD
   operations in Ruby on Rails applications as preconfigured `sidekiq` background job."
  spec.description = "This gem provides three convenient methods for common CRUD operations:
   `delayed_create`, `delayed_update` and `delayed_destroy` as preconfigured `sidekiq`
   background job for Ruby on Rails applications."

  spec.homepage = "https://github.com/msuliq/delayed_crud"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/msuliq/delayed_crud"
  spec.metadata["changelog_uri"] = "https://github.com/msuliq/delayed_crud/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "rails", "~> 5.0"
  spec.add_dependency "sidekiq", "~> 2.15"
end
