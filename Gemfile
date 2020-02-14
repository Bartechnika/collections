source 'https://rubygems.org'

ruby File.read(".ruby-version").strip

gem 'dalli'
gem 'gds-api-adapters', '~> 63.4.0'
gem 'govuk_ab_testing', '~> 2.4.1'
gem 'govuk_app_config', '~> 2.0.3'
gem 'govuk_document_types'
gem 'govuk_publishing_components', github: "alphagov/govuk_publishing_components", branch: "increse-spacing-document-list-for-test-only"
gem 'govspeak', '~> 6.5.3'
gem 'plek', '~> 3.0.0'
gem 'rails', '5.2.4.1'
gem 'rinku', require: 'rails_rinku'
gem 'sass-rails', '~> 5.0.3'
gem 'slimmer', '~> 13.2.0'
gem 'uglifier', '~> 4.2.0'

group :test do
  gem 'cucumber-rails', require: false
  gem 'govuk_schemas', '~> 4.0.0'
  gem 'govuk_test', '~> 1.0.3'
  gem 'govuk-content-schema-test-helpers'
  gem 'minitest-spec-rails'
  gem 'mocha'
  gem 'simplecov'
  gem 'simplecov-rcov'
  gem 'webmock', require: false
  gem 'rails-controller-testing'
end

group :development, :test do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'jasmine-rails'
  gem 'pry-byebug'
  gem 'rubocop-govuk'
  gem 'timecop'
end
