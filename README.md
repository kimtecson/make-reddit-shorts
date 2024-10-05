
# make-reddit-shorts

Easily create short-form content based on a chosen Reddit posts, an app meant for those seeking help with creating an automated faceless social media channel with little to no effort.

## Requirements

You must have the following keys:
- **AWS S3 bucket**
- **OpenAI API key**

Sofware dependencies:
- **Rails**: 7.x
- **FFMPEG**: 7.x
- **Ruby**: 3.x
- **PostgreSQL**: 14.x
  
## Setup Instructions

### 1. Clone the Repository

```bash
git clone <repository_url>
cd make-reddit-shorts
```

### 2. Install Dependencies and set up Database

```bash
bundle install
rails active_storage:install
rails db:migrate
rails assets:precompile
```
### 3. Seed the Database (adding background videos from AWS)

```bash
rails db:seed
```

### 4. Configure Master Key

```bash
touch config/master.key
EDITOR="code --wait" bin/rails credentials:edit
```

Make sure the `config/master.key` file is in place and contains the correct credentials.

## Running the Application

To run the Rails server:

```bash
rails s
```

Visit `http://localhost:3000` to access the application.

## Tasks before Launch

| Task | Status |
|------|--------|
| Update TTS logic           | ❌ |
| Restructure loading bar code| ❌ |
| Introduce IP verification   | ❌ |
| Update password validation  | ❌ |
| Host the project            | ❌ |
| Implement DDoS protection   | ❌ |

## Deployment Instructions

1. Configure your cloud provider (e.g., AWS, Heroku, etc.).
2. Make sure you have the correct environment variables in place for production.
3. (Additional deployment steps specific to your hosting platform).

## Security Considerations

- **IP Verification**: To be implemented.
- **Password Validation**: Updates pending.
- **DDoS Protection**: Pending implementation.

## Contributors

- [@kimtecson](https://github.com/kimtecson)

