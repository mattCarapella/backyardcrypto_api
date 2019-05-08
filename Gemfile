source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby '2.5.1'

gem 'rails', '~> 5.2.3'																		# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'pg', '>= 0.18', '< 2.0'															# Use postgresql as the database for Active Record
gem 'puma', '~> 3.11'																			# Use Puma as the app server
gem 'jb', '~> 0.7.0'
# gem 'redis', '~> 4.0'																		# Use Redis adapter to run Action Cable in production
# gem 'bcrypt', '~> 3.1.7' 																# Use ActiveModel has_secure_password
			
# gem 'mini_magick', '~> 4.8' 														# Use ActiveStorage variant
# gem 'capistrano-rails', group: :development 						# Use Capistrano for deployment
gem 'bootsnap', '>= 1.1.0', require: false 								# Reduces boot times through caching; required in config/boot.rb

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw] 		# Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
	#gem 'factory_girl', '~> 4.9'   							# deprecated -> use factory bot
	#gem 'ffaker', '~> 2.11'
	gem 'faker', '~> 1.9', '>= 1.9.3'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring' 																						# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rb-readline'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby] 				# Windows does not include zoneinfo files, so bundle the tzinfo-data gem

gem 'devise', '~> 4.6', '>= 4.6.2'
gem 'simple_token_authentication', '~> 1.0'

gem 'jwt', '~> 2.1'
gem 'rack-cors', '~> 1.0', '>= 1.0.3'
gem 'httparty', '~> 0.16.4'
gem 'recaptcha', '~> 4.13', '>= 4.13.1'
gem 'geocoder', '~> 1.5'
gem 'acts_as_votable', '~> 0.11.1'
gem 'friendly_id', '~> 5.2', '>= 5.2.5'
gem 'rack-attack', '~> 6.0'
gem 'cancancan', '~> 3.0', '>= 3.0.1'
