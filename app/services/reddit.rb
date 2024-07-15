require 'net/http'
require 'uri'
require 'json'
require 'dotenv/load'

class RedditPost
  CLIENT_ID = ENV['REDDIT_CLIENT_ID']
  SECRET = ENV['REDDIT_SECRET']
  USER_AGENT = 'RubyScript/1.0'
  AUTH_URL = 'https://www.reddit.com/api/v1/access_token'

  def write_script(reddit_post_url)
    post_id = get_post_id(reddit_post_url)
    post_content = fetch_reddit_post(post_id)
    File.open('app/services/resources/script.txt', 'w') do |file|
      file.write(post_content)
    end
  end

  private

  def get_token
    uri = URI(AUTH_URL)
    req = Net::HTTP::Post.new(uri)
    req.basic_auth(CLIENT_ID, SECRET)
    req.set_form_data('grant_type' => 'client_credentials')
    req['User-Agent'] = USER_AGENT

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }

    if res.is_a?(Net::HTTPSuccess)
      JSON.parse(res.body)['access_token']
    else
      Rails.logger.error("Failed to get token. HTTP #{res.code}: #{res.body}")
      nil
    end
  end

  def fetch_reddit_post(post_id)
    token = get_token
    return unless token

    post_url = "https://oauth.reddit.com/api/info/?id=t3_#{post_id}"
    uri = URI(post_url)
    req = Net::HTTP::Get.new(uri)
    req['Authorization'] = "Bearer #{token}"
    req['User-Agent'] = USER_AGENT

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) { |http| http.request(req) }

    if res.is_a?(Net::HTTPSuccess)
      data = JSON.parse(res.body)
      post = data['data']['children'][0]['data']
      post['selftext']
    else
      Rails.logger.error("Failed to fetch Reddit post. HTTP #{res.code}: #{res.body}")
      nil
    end
  end

  def get_post_id(url)
    regex = %r{https:\/\/www\.reddit\.com\/r\/[a-zA-Z0-9_]+\/comments\/([a-zA-Z0-9]+)\/}
    match = url.match(regex)
    match[1] if match
  end
end
