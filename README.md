### Run `make-reddit-shorts`
In order to run the code from this repo you must run the commands below:
```
rails active_storage:install
rails db:migrate
rails assets:precompile
bundle install
```
- Log into the site at `localhost:3000` and create a user
- Download FFMPEG version 7.x

- Run the following commands:
```
rails db:seed
touch .env
echo '.env*' >> .gitignore
```
In the new `.env` file set the variables:
```
OPENAI_API_KEY=
REDDIT_CLIENT_ID=
REDDIT_SECRET=
AWS_ACCESS_KEY=
AWS_SECRET_KEY=
AWS_BUCKET_NAME=
```
