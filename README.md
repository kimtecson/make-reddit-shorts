### Run
In order to run the code from this repo you must:
- run migrations
- install active storage
- bundle install
- precompile assets
- seed initial source and batch (batch to be removed later)
```
rails active_storage:install
rails db:migrate
bundle install
rails assets:precompile
rails db:seed
```
- create an env file
```
touch .env
echo '.env*' >> .gitignore
```
- set the correct variables for:
```
OPENAI_API_KEY=
REDDIT_CLIENT_ID=
REDDIT_SECRET=
```

Create:
- Batch
- Source
- User

```
rails c
user = User.find_or_create_by(email: 'test@example.com') do |u|
  u.password = 'password'
  u.password_confirmation = 'password'
end
sn = Source.new(url: 'your_video_url_here', user_id: user.id)
if sn.save
  puts 'Source saved successfully'
else
  puts sn.errors.full_messages
end

```

Ask stan if you have any questions
