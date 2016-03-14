json.array!(@feeds) do |feed|
  json.extract! feed, :id, :user_id, :up_vote_count, :down_vote_count, :feed_type, :feed_content, :interest
  json.url feed_url(feed, format: :json)
end
