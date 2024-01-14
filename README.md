# Rails-Discum Forum Backend database

PostgreSQL Back-end database built with Ruby on Rails linked to a [Front-end system built with React.js](https://github.com/Feng1231/CVWO-frontend) for a Forum

## System dependencies
- node.js
- npm
- PostgreSQL

## Installing gemfiles
### Ruby version
This project is built with Ruby 3.2.2
```
rbenv install 3.2.2
```

ensure you are using the desired Ruby version to install.
```
ruby --version
```

set ruby default version
```
rbenv global 3.2.2
```

### Bundler version
Bundler manages gems, but the mismatch of bundler version may cause an error to occur. If you already have Bundler ( bundler — version), you could skip this section and see if it works. If an error that relates to Bundler versions occurs, an older or newer version may be required.

This project uses bundler version 2.4.22.

check bundler version
```
bundler version
```

This will install the bundler gem in Ruby 3.2.2
```
gem install bundler -v 2.4.22
```
2.4.22

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