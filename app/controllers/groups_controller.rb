class GroupsController < ApplicationController
  def index
    @groups = Group.all

    api_groups = []
    @groups.each do |group|
      api_groups.push({id: group.id, name: group.name, teacher: "#{group&.teacher&.name} #{group&.teacher&.surname}", teacher_id: group&.teacher_id})
    end

    respond_to do |format|
      format.html
      format.json { render json: api_groups }
    end
  end

  def new
    @selection = Teacher.all.collect {|p| [ p.name, p.id ] }
  end

  def create
    parameters = params[:group]
    group = Group.create(name: parameters[:name])
    unless parameters[:teacher_id].blank?
      teacher = Teacher.find(parameters[:teacher_id])

      if teacher.group.blank?
        group.update(teacher: teacher)
      else
        teacher.group.update(teacher: nil)
        group.update(teacher: teacher)
      end
    end

    if group.errors.blank?
      respond_to do |format|
        format.html { redirect_to groups_path }
        format.json { render json: {success: true} }
      end
    else
      flash[:errors] = group.errors
      respond_to do |format|
        format.html { redirect_to new_group_path }
        format.json { render json: {erros: group.errors} }
      end
    end
  end

  def edit
    @group = Group.find(params[:id])
    @selection = Teacher.all.collect {|p| [ p.name, p.id ] }
  end

  def update
    parameters = params[:group]
    group = Group.find(params[:id])
    group.update(name: parameters[:name])

    if !parameters[:teacher_id].blank?
      teacher = Teacher.find(parameters[:teacher_id])

      if teacher.group.blank?
        group.update(teacher: teacher)
      else
        teacher.group.update(teacher: nil)
        group.update(teacher: teacher)
      end
    else
      group.update(teacher: nil)
    end

    if group.errors.blank?
      respond_to do |format|
        format.html { redirect_to groups_path }
        format.json { render json: {success: true} }
      end
    else
      flash[:errors] = group.errors
      respond_to do |format|
        format.html { redirect_to new_group_path }
        format.json { render json: {errors: group.errors} }
      end
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy

    respond_to do |format|
      format.html { redirect_to groups_path }
      format.json { render json: {success: true} }
    end
  end

  def show
    @group = Group.find(params[:id])

    api_students = []
    @group.students.each do |student|
      api_students << {name: student&.name, surname: student&.name}
    end

    respond_to do |format|
      format.html
      format.json { render json: api_students }
    end
  end
end
