class TeachersController < ApplicationController
  def index
    @teachers = Teacher.all

    respond_to do |format|
      format.html
      format.json { render json: @teachers }
    end
  end

  def edit
    @teacher = Teacher.find(params[:id])
  end

  def destroy
    teacher = Teacher.find(params[:id])
    teacher.destroy

    respond_to do |format|
      format.html { redirect_to teachers_path }
      format.json { render json: {success: true} }
    end
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
      respond_to do |format|
        format.html { redirect_to teachers_path }
        format.json { render json: {success: true} }
      end
    else
      flash[:errors] = teacher.errors
      respond_to do |format|
        format.html { redirect_to edit_teacher_path }
        format.json { render json: {errors: teacher.errors} }
      end
    end
  end

  def create
    parameters = params[:teacher]

    teacher = Teacher.create(surname: parameters[:surname],
                              name: parameters[:name],
                              subject: parameters[:subject])

    if teacher.errors.blank?
      respond_to do |format|
        format.html { redirect_to teachers_path }
        format.json { render json: {success: true} }
      end
    else
      flash[:errors] = teacher.errors
      respond_to do |format|
        format.html { redirect_to new_teacher_path }
        format.json { render json: {errors: teachers.errors} }
      end
    end
  end
end
