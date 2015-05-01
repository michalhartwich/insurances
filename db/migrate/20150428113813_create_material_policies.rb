class CreateMaterialPolicies < ActiveRecord::Migration
  def change
    create_table :material_policies do |t|
      t.belongs_to :client, index: true
      t.references :group, index: true

      t.string :number
      t.datetime :sign_date
      t.datetime :begin_date
      t.datetime :expire_date
      t.text :comments

      t.timestamps null: false
    end

    create_table :items_material_policies do |t|
      t.references :material_policy, index: true
      t.references :item, index: true
      t.timestamps null: false
    end
  end
end
