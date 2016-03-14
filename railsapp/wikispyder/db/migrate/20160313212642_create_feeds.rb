class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.integer :user_id
      t.integer :up_vote_count
      t.integer :down_vote_count
      t.string :feed_type
      t.string :feed_content
      t.integer :interest

      t.timestamps null: false
    end
  end
end
