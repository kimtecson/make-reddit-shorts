class CreateNewsletterSubscribers < ActiveRecord::Migration[7.1]
  def change
    create_table :newsletter_subscribers do |t|

      t.timestamps
    end
  end
end
