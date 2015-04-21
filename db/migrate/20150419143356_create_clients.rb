class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :surname
      t.string :name
      t.string :company
      t.string :PESEL
      t.string :REGON
      t.string :telephone_number
      t.string :e_mail
      t.string :street
      t.string :city
      t.string :zip_code
      t.text :comments

      t.timestamps null: false
    end
  end
end
