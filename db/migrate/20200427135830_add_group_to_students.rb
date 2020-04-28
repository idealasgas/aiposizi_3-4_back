class AddGroupToStudents < ActiveRecord::Migration[6.0]
  def change
    add_reference :students, :group
  end
end
