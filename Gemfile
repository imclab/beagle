source 'https://rubygems.org'

gem 'rails', '3.2.14'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
end

gem 'mongoid'
gem 'delayed_job_mongoid'
gem 'feedzirra', github: 'pauldix/feedzirra'


group :development do
  gem 'thin'
  gem 'quiet_assets'
  gem "guard-rspec"
  gem "spork"
  gem "guard-spork"
  gem 'rb-fsevent'
  gem "terminal-notifier-guard"
  # gem 'rails-dev-tweaks', '~> 0.6.1'
end

group :test do 
	gem "capybara"
	gem "database_cleaner"
	gem "mongoid-rspec"
end 

group :development, :test do 
	gem "rspec-rails"
	gem "factory_girl_rails"
end 