class AddTeacherToGroup < ActiveRecord::Migration[6.0]
  def change
    add_reference :groups, :teacher
  end
end
