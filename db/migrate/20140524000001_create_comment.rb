class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post
      t.integer :user
      t.string :content
    end
  end
end
