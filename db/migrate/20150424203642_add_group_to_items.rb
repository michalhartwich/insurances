class AddGroupToItems < ActiveRecord::Migration
  def change
    add_reference :items, :group, index: true
    add_foreign_key :items, :groups
  end
end
