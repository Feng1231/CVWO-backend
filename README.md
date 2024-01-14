# Rails-Discum Forum Backend database

PostgreSQL Back-end database built with Ruby on Rails linked to a [Front-end system built with React.js](https://github.com/Feng1231/CVWO-frontend) for a Forum

## System dependencies
- node.js
- npm
- PostgreSQL
- Ruby

## Installing gemfiles
### Ruby version
This project is built with Ruby 3.2.2
ensure you are using the desired Ruby version to install.
```
ruby --version
```

### Bundler version
Bundler manages gems, but the mismatch of bundler version may cause an error to occur. If you already have Bundler ( bundler — version), you could skip this section and see if it works. If an error that relates to Bundler versions occurs, an older or newer version may be required.

This project uses bundler version 2.4.22

check bundler version
```
bundler --version
```

This will install the bundler gem in Ruby 3.2.2
```
gem install bundler -v 2.4.22
```


### Install the required gems

```
bundle
```
or
```
bundle install
```

## Database 
* ensure you have your default postgresql user and password configured in '/config/database.yml', make changes to the user and password accordingly if needed.
* ensure url in '/config/initializers/cors.rb' is correctly configured to be your frontend base url.

create database
```
rails db:create
```

migrate database
```
rails db:migrate
```

##
start your server
```
rails s
```

## Author

- Github: [@Feng1231](https://github.com/Feng1231)
- Linkedin: [Chen Feng](https://www.linkedin.com/in/feng-chen-356221289/)
