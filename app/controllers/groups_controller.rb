class GroupsController < ApplicationController
  def index
    @groups = Group.all
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
      redirect_to groups_path
    else
      flash[:errors] = group.errors
      redirect_to new_group_path
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
      redirect_to groups_path
    else
      flash[:errors] = group.errors
      redirect_to new_group_path
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy

    redirect_to groups_path
  end

  def show
    @group = Group.find(params[:id])
  end
end
