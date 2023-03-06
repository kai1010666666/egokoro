class CreateTagIllustrations < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_illustrations do |t|
      # Illustrationと関連付ける
      #   references型を使用して予想外のidが入らないようにする
      t.references :illustration, foreign_key: true
      # Tagと関連付けるためのカラム
      #   references型を使用して予想外のidが入らないようにする
      t.references :tag, foreign_key: true
      t.timestamps
    end
  end
end
