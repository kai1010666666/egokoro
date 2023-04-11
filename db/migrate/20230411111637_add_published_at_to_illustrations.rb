class AddPublishedAtToIllustrations < ActiveRecord::Migration[6.1]
  def change
    add_column :illustrations, :published_at, :timestamp
  end
end
