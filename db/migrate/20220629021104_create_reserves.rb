class CreateReserves < ActiveRecord::Migration[6.1]
  def change
    create_table :reserves do |t|
      t.date :start_day
      t.date :end_day
      t.integer :number_of_people
      t.integer :user_id
      t.integer :room_id

      t.timestamps
    end
  end
end
