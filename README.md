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

## Todo

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* Initialize .env file with the following environmental variables:
  * AWS_ACCESS_KEY_ID=
  * AWS_SECRET_ACCESS_KEY=
  * S3_BUCKET_NAME=
  * S3_HOST_NAME=
  * ASSET_HOST=
  * S3_REGION=
  * HTTP_AUTH_USERNAME=
  * HTTP_AUTH_PASSWORD=
  * GOOGLE_ANALYTICS_SITE_ID=
  * MAILCHIMP_API_KEY=
  * MAILCHIMP_SPLASH_SIGNUP_LIST_ID=
  * FACEBOOK_APP_ID=
  * FACEBOOK_APP_SECRET=
  * GOOGLE_OAUTH2_APP_ID=
  * GOOGLE_OAUTH2_APP_SECRET=
  * TWITTER_APP_ID=
  * TWITTER_APP_SECRET=
  * GITHUB_APP_ID=
  * GITHUB_APP_SECRET=
  * DOMAIN_NAME=test.host
  * GITHUB_WEBHOOK_SECRET=
  * AIRBRAKE_API_KEY=
  * AIRBRAKE_HOST=
  * S3_BUCKET=bucket
  * S3_ACCESS_KEY=abc
  * S3_SECRET_KEY=abc
  * S3_REGION=us-west

* ...
