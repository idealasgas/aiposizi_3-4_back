class AddTeacherToClassroom < ActiveRecord::Migration[6.0]
  def change
    add_reference :classrooms, :teacher
  end
end
