class ChangeUserInStories < ActiveRecord::Migration[6.1]
  def change
    remove_reference :stories, :user,index: true
    add_reference :stories, :user, index: true
  end
end
