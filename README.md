# Make Reddit Shorts
Easily create short form videos from reddit posts.

### Depenencies
- Rails 7.x
- FFMPEG version 7.x

### Run
In order to run the code from this repo:
```
bundle install
rails active_storage:install
rails db:migrate
rails assets:precompile
rails db:seed
```

### Credentials

```
touch config/master.key
EDITOR="code --wait" bin/rails credentials:edit
```
