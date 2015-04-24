class GroupsController < ApplicationController

  def index
    @groups = Group.all
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      flash[:success] = t 'groups.create_success'
      redirect_to groups_path
    else
      flash.now[:danger] = t 'helpers.form_error'
      flash.now[:errors] = @group.errors
      render 'new'
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update_attributes(group_params)
      redirect_to groups_path, success: t('groups.update_success', group: @group.name)
    else
      flash.now[:danger] = t 'helpers.form_error'
      flash.now[:errors] = @group.errors
      render 'edit'
    end
  end

  def destroy
    @group = Group.destroy(params[:id])
    flash[:success] = t 'groups.destroy_success', group: @group.name
    redirect_to groups_path
  end

  private
    def group_params
      params.require(:group).permit(:name, :description)
    end
end
