Datasets Analysis
=================

Datasets Analysis is a single page web application which analyzes some important data. The application was implemented as a Single Page Application on top of JSON API using Ruby with Rails framework. AngularJS was used as a Frontend framework.

* Ruby version 2.2.2

* Rails version 4.2.6

* AngularJS version 1.0.2

Features
--------
Users are able to sign up and sign in with the login and password.
Users are able to enter array of data in format "1,3,4,3,2,3,4,2".
Users are able to analyze an array of numbers and check the correlation between two datasets.

Analysis includes:

* max value
* min value
* average value
* median
* Q1 (first quartile)
* Q3 (third quartile)
* outliers

##### You can check this application at https://datasets-analysis-max.herokuapp.com/

System dependencies
-------------------
You should have installed ruby version 2.2.2, SQLite 3.x database for development and test environment and any version of PostgreSQL for production environment.

Environment variables configuration
-----------------------------------
You need to set `SECRET_KEY_BASE` environment variable for Devise for production environment (configuration for development and test environment storing at `config/secrets.yml`).
To do this you should go to your project directory and run the command below and copy the output:

    $ bundle exec rake secret

Then if you have bash interpreter, run:

    $ SECRET_KEY_BASE=your_secret_key

where your_secret_key is the command output above.

For fish interpreter use:

    $ set SECRET_KEY_BASE your_secret_key

To check your variable use:

    $ echo $SECRET_KEY_BASE

The command should print your variable value.

Database configuration
----------------------
To configure your database edit `config/database.yml` file.
If you not use heroku, you should add 'database', 'username' and 'password' values of your database for production environment.

Database creation
-----------------
Simple run:

    $ bundle exec rake db:migrate

Assets compilation
------------------
Before running the application in production environment you should precompile assets. Simple run:

    $ bundle exec rake assets:precompile

Tests
-----
To run the test suite just run:

    $ bundle exec rspec

Run instructions
----------------
Once you have set up your environment, you could run your application.
##### Production:

    $ bundle exec rails server -p 80 -e production

##### Development:

    $ budle exec rails server -e development

Development environment will use port 3000 by default.