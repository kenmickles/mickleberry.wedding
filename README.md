## mickleberry.wedding

Basic-ass Rails 4 website + some rake tasks for creating mailing labels, stealing photos from Instagram, etc. You know, wedding stuff.

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
