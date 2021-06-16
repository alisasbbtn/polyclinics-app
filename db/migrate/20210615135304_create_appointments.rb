class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.belongs_to :doctor, null: false
      t.belongs_to :patient, null: false
      t.datetime :datetime, null: false
      t.text :recommendations
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
