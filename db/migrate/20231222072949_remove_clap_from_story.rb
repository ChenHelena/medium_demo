class RemoveClapFromStory < ActiveRecord::Migration[6.1]
  def change
    remove_column :stories, :clap, :integer
  end
end
