# README

Don't forget to ask Stan for .env file:

- OPENAI_API_KEY
- REDDIT_CLIENT_ID
- REDDIT_SECRET

In order for the video generation to run:

- rails active_storage:install
- rails db:migrate

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
