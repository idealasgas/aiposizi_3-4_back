class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def create
    parameters = params[:student]

    student = Student.create(surname: parameters[:surname],
                        name: parameters[:name])
    group = Group.find_by(name: parameters[:group_name])
    unless group.blank?
      student.update(group: group)
    end

    if student.errors.blank?
      redirect_to students_path
    else
      flash[:errors] = student.errors
      redirect_to new_student_path
    end
  end

  def new
  end

  def edit
    @student = Student.find(params[:id])
  end

  def show
  end

  def update
    parameters = params[:student]
    student = Student.find(params[:id])

    student.update(surname: parameters[:surname],
                        name: parameters[:name])
    group = Group.find_by(name: parameters[:group_name])
    unless group.blank?
      student.update(group: group)
    end

    if student.errors.blank?
      redirect_to students_path
    else
      flash[:errors] = student.errors
      redirect_to edit_student_path
    end
  end

  def destroy
    student = Student.find(params[:id])
    student.destroy

    redirect_to students_path
  end
end
