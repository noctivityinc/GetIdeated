source 'http://rubygems.org'

gem 'rails', '3.1.2'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'


group :development, :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'
end

group :production do
	gem 'pg'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.1.5.rc.2'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'haml'
gem 'haml-rails'
gem 'devise'
gem 'formtastic'
gem 'tabletastic'
gem 'gravatar_image_tag'
gem "breadcrumbs_on_rails"
gem 'postmark-rails'
gem 'RedCloth'

gem "nifty-generators", :group => :development

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server
gem 'unicorn'

# To use debugger
group :development, :test do
  gem 'ruby-debug19', :require => 'ruby-debug'
end

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
end
gem "mocha", :group => :test
