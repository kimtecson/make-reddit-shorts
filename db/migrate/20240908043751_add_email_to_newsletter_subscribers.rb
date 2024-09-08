class AddEmailToNewsletterSubscribers < ActiveRecord::Migration[7.1]
  def change
    add_column :newsletter_subscribers, :email, :string
  end
end
