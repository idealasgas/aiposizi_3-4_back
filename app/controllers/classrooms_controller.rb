class ClassroomsController < ApplicationController
  def index
    @classrooms = Classroom.all
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
      redirect_to classrooms_path
    else
      flash[:errors] = classroom.errors
      redirect_to new_classroom_path
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
      teacher = Teacher.find(parameters[:teacher_id])

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
      redirect_to classrooms_path
    else
      flash[:errors] = classroom.errors
      redirect_to new_classroom_path
    end
  end

  def destroy
  end
end
