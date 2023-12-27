class CreateStories < ActiveRecord::Migration[6.1]
  def change
    create_table :stories do |t|
      t.string :title
      t.text :content
      t.string :status,default:'draft'
      t.references :user
      
      t.timestamps
    end
  end
end
