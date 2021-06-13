class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :phone_number, null: false, index: { unique: true }
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :patronymic, null: false
      t.date :birth_date
      t.integer :gender

      t.timestamps
    end
  end
end
