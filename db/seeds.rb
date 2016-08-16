# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
organization = Organization.find_or_create_by!(name: 'playpenlabs')
User.create!(email: 'admin@categorizer.com', password: 'categorizer', password_confirmation: 'categorizer', zendesk_email: 'zendesk@playpenlabs.com', zendesk_password: 'devzd', organization: organization)
