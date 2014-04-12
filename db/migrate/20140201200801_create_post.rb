class CreatePost < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.datetime :date
      t.string :image
      t.string :content
      t.string :tags
      t.integer :likes
      t.boolean :private
    end
  end
end
