class CreateClassrooms < ActiveRecord::Migration[6.0]
  def change
    create_table :classrooms do |t|
      t.integer :number

      t.timestamps
    end
  end
end
