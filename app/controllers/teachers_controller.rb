class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def destroy
    teacher = Teacher.find(params[:id])
    teacher.destroy

    redirect_to teachers_path
  end

  def new
  end

  def update
    parameters = params[:teacher]
    teacher = Teacher.find(params[:id])

    teacher.update(surname: parameters[:surname],
                    name: parameters[:name],
                    subject: parameters[:subject])

    if teacher.errors.blank?
      redirect_to teachers_path
    else
      flash[:errors] = teacher.errors
      redirect_to edit_teacher_path
    end
  end

  def create
    parameters = params[:teacher]

    teacher = Teacher.create(surname: parameters[:surname],
                              name: parameters[:name],
                              subject: parameters[:subject])

    if teacher.errors.blank?
      redirect_to teachers_path
    else
      flash[:errors] = teacher.errors
      redirect_to new_teacher_path
    end
  end
end
