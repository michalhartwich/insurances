class AddPaidToInstallments < ActiveRecord::Migration
  def change
    add_column :installments, :paid, :boolean
  end
end
