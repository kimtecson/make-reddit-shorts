class AddRedditPostUrlToSources < ActiveRecord::Migration[7.1]
  def change
    add_column :outputs, :reddit_post_url, :string
  end
end
