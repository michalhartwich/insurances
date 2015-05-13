class RenameColsInClients < ActiveRecord::Migration
  def change
    rename_column :clients, :REGON, :regon
    rename_column :clients, :PESEL, :pesel
  end
end
