# README

This is a phone code lookup tool written with React and Rails. By default its database is seeded with German phone codes.

It lets users look up codes by full phone number or usage. Some regions of Germany have names with accented symbols such as `ö`. Search takes different ways of handling them into account: it's possible to find Köln by looking up Koln, Köln and Koeln.

Demo: https://cryptic-fortress-34045.herokuapp.com/

## Requirements
* ruby 2.4.1p111
* Rails 5.2.3
* Yarn 1.19.1
* [geckodriver](https://github.com/mozilla/geckodriver/releases) for feature tests

## Installation
```bash
git clone git@github.com:SteveRedka/germany_phone_codes.git
cd germany_phone_codes
bundle
rake db:create
rake db:migrate
rake db:seed
```

## Deployment
### Heroku
```bash
heroku create
git push heroku master
heroku run rake db:migrate
heroku run rake db:seed
```
