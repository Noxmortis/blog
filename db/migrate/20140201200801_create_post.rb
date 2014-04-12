class CreatePost < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :owner
      t.datetime :date
      t.string :content
      t.string :image
      t.string :tags
      t.integer :likes
      t.boolean :private
    end
  end
end
