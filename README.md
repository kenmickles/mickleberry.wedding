## mickleberry.wedding

Just a basic-ass Rails 4 website.

### Setup
```
rvm install 2.2.4
git clone git@github.com:kenmickles/mickleberry.wedding.git
cd mickleberry.wedding
cp dotenv.sample .env
(edit .env)
bundle
rake db:setup
rails s
```