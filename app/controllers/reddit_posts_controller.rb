# app/controllers/reddit_posts_controller.rb
#require_dependency 'reddit_post'
class RedditPostsController < ApplicationController
  def show
    reddit_post = RedditPost.new
    post_url = params[:url]
    post_content = reddit_post.fetch_reddit_post_text(reddit_post.get_post_id(post_url))

    render json: { selftext: post_content }
  end
end
