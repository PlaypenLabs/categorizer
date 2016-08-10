#Categorizer

- Ruby version `2.3`
- Rails version `4.2.4`

##Configuration
  1. Clone repository `git clone git@github.com:PlaypenLabs/categorizer.git`
  2. Open directory project `cd categorizer`
  3. Install ruby if not installed `rvm install ruby 2.3`
  4. Install gem bundler if is not installed for ruby 2.3 `gem install bundler`
  5. Run `bundle install`
  6. Run rails server `rails s`

##Database initialization
We using PostgreSQL database it should be installed.
  1. Create a file `database.yml` in `config` directory and copy there a content from the file `database_example.yml`, also confiqure the access to your DB.

##Database creation
  1. Create DB `rake db:create`
  2. Run Migration `rake db:migrate`
  3. Run `rake db:seed` for create Admin and User


