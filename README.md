# AlphaGrader

[![CircleCI](https://circleci.com/gh/rhomeister/alphagrader.svg?style=svg)](https://circleci.com/gh/rhomeister/alphagrader)

## Dependencies

- `dos2unix`
- `docker`

## Docker
Alphagrader uses a docker image to run submissions in isolation.

Common tasks:

- Install image: `docker pull rhomeister/alphagrader`
- Building a new image:
  - `docker build -t rhomeister/alphagrader .`
  - `docker push rhomeister/alphagrader:latest`

## Initial setup
Alphagrader requires the following to function correctly:
- PostgreSQL
- `docker`
- `ruby` 2.5.5
- [`bundler`](https://bundler.io/)

Additionally, it is important to create a `.env` file with the following 
contents:
```
AWS_ACCESS_KEY_ID=
AWS_SECRET_ACCESS_KEY=
S3_BUCKET_NAME=
S3_HOST_NAME=
ASSET_HOST=
S3_REGION=
HTTP_AUTH_USERNAME=
HTTP_AUTH_PASSWORD=
GOOGLE_ANALYTICS_SITE_ID=
MAILCHIMP_API_KEY=
MAILCHIMP_SPLASH_SIGNUP_LIST_ID=
FACEBOOK_APP_ID=
FACEBOOK_APP_SECRET=
GOOGLE_OAUTH2_APP_ID=
GOOGLE_OAUTH2_APP_SECRET=
TWITTER_APP_ID=
TWITTER_APP_SECRET=
GITHUB_APP_ID=
GITHUB_APP_SECRET=
DOMAIN_NAME=test.host
GITHUB_WEBHOOK_SECRET=
AIRBRAKE_API_KEY=
AIRBRAKE_HOST=
S3_BUCKET=bucket
S3_ACCESS_KEY=abc
S3_SECRET_KEY=abc
S3_REGION=us-west
```
### PostgreSQL setup
Create the following role in `psql`:
```
postgres=# createuser -P --interactive
Enter name of role to add: alphagrader
Enter password for new role: alphagrader
Shall the new role be a superuser? (y/n) y
```

Now create the following databases:
```
postgres@server:~$ createdb alphagrader-development
postgres@server:~$ createdb alphagrader-test
```

For details, see `database.yml`.

### `bundler`
Install Alphagrader `ruby` dependencies:
```bash
$ bundle install
```

#### Tests
To perform the tests, run:
```bash
$ bundle exec rspec
```

The output should end with the following line:
```
83 examples, 0 failures, 1 pending
```