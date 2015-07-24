# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( admin/reset.css )
Rails.application.config.assets.precompile += %w( admin/bootstrap.css )
Rails.application.config.assets.precompile += %w( admin/admin.css )

Rails.application.config.assets.precompile += %w( jquery.js )
Rails.application.config.assets.precompile += %w( jquery_ujs.js )
Rails.application.config.assets.precompile += %w( jquery.validate.js )
Rails.application.config.assets.precompile += %w( admin/admin.js)
Rails.application.config.assets.precompile += %w( admin/jquery-1.2.6.min.js )
Rails.application.config.assets.precompile += %w( admin/jquery.tablesorter.js )
Rails.application.config.assets.precompile += %w( admin/dashboard.js )
Rails.application.config.assets.precompile += %w( auth0-4.2.min.js )
Rails.application.config.assets.precompile += %w( ckeditor/* )


