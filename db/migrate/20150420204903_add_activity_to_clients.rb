class AddActivityToClients < ActiveRecord::Migration
  def change
    add_column :clients, :activity, :integer
  end
end
