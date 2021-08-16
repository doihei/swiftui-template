source "https://rubygems.org"

gem "fastlane"
gem "danger"
gem 'danger-swiftlint'
gem "cocoapods"
gem 'generamba', github: 'strongself/Generamba', :branch => "develop"
gem "xcodeproj"

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
