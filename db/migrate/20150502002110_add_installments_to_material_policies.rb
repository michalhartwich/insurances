class AddInstallmentsToMaterialPolicies < ActiveRecord::Migration
  def change
    add_column :material_policies, :contribution, :decimal, :precision => 8, :scale => 2
    add_column :material_policies, :sum, :decimal, :precision => 8, :scale => 2
  end
end
