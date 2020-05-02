class ClassroomsController < ApplicationController
  def index
    @classrooms = Classroom.all

    api_classrooms = []
    @classrooms.each do |classroom|
      api_classrooms.push({id: classroom.id, number: classroom.number, teacher: "#{classroom&.teacher&.name} #{classroom&.teacher&.surname}", teacher_id: classroom&.teacher&.id})
    end

    respond_to do |format|
      format.html
      format.json { render json: api_classrooms }
    end
  end

  def new
    @selection = Teacher.all.collect { |t| [t.name, t.id] }
  end

  def create
    parameters = params[:classroom]
    classroom = Classroom.create(number: parameters[:number])
    unless parameters[:teacher_id].blank?
      teacher = Teacher.find(parameters[:teacher_id])

      if teacher.classroom.blank?
        classroom.update(teacher: teacher)
      else
        teacher.classroom.update(teacher: nil)
        classroom.update(teacher: teacher)
      end
    end

    if classroom.errors.blank?
      respond_to do |format|
        format.html { redirect_to classrooms_path }
        format.json { render json: {success: true} }
      end
    else
      flash[:errors] = classroom.errors
      respond_to do |format|
        format.html { redirect_to new_classroom_path }
        format.json { render json: {errors: classroom.errors} }
      end
    end
  end

  def edit
    @classroom = Classroom.find(params[:id])
    @selection = Teacher.all.collect {|p| [ p.name, p.id ] }
  end

  def update
    parameters = params[:classroom]
    classroom = Classroom.find(params[:id])
    classroom.update(number: parameters[:number])

    if !parameters[:teacher_id].blank?
      teacher = Teacher.find(parameters[:teacher_id].to_i)

      if teacher.classroom.blank?
        classroom.update(teacher: teacher)
      else
        teacher.classroom.update(teacher: nil)
        classroom.update(teacher: teacher)
      end
    else
      classroom.update(teacher: nil)
    end

    if classroom.errors.blank?
      respond_to do |format|
        format.html { redirect_to classrooms_path }
        format.json { render json: {success: true} }
      end
    else
      flash[:errors] = classroom.errors
      respond_to do |format|
        format.html { redirect_to new_classroom_path }
        format.json { render json: {errors: classroom.errors} }
      end
    end
  end

  def destroy
  end
end
