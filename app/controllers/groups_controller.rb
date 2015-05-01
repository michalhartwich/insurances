class GroupsController < ApplicationController

  expose(:group, attributes: :group_params)

  def index
    @groups = Group.all
  end

  def create
    if group.save
      flash[:success] = t 'groups.create_success'
      redirect_to groups_path
    else
      flash.now[:danger] = t 'helpers.form_error'
      flash.now[:errors] = group.errors
      render 'new'
    end
  end

  def update
    if group.save
      redirect_to groups_path, success: t('groups.update_success', group: group.name)
    else
      flash.now[:danger] = t 'helpers.form_error'
      flash.now[:errors] = group.errors
      render 'edit'
    end
  end

  def destroy
    flash[:success] = t 'groups.destroy_success', group: group.name
    redirect_to groups_path
  end

  def items
    @items = Item.where(group_id: params[:group_id])
    respond_to do |f|
      f.html
      f.json {render json: @items}
    end
  end

  private
    def group_params
      params.require(:group).permit(:name, :description)
    end
end
