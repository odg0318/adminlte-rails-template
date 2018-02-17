# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

CreateAdminService.new.create_roles
puts 'CREATED ROLES: ' << user.email
user = CreateAdminService.new.create_admin
puts 'CREATED ADMIN USER: ' << user.email
# Environment variables (ENV['...']) can be set in the file .env file.
