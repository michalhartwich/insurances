class CreateInstallments < ActiveRecord::Migration
  def change
    create_table :installments do |t|
      t.references :instable, polymorphic: true, index: true
      t.decimal :amount, :precision => 8, :scale => 2
      t.datetime :pay_date

      t.timestamps null: false
    end
    # add_index :installments, 
  end
end
