class ItemsController < ApplicationController

  expose(:item, attributes: :item_params)

  def initialize
    @groups = Group.all
    super
  end

  def index
    @items = Item.all
  end

  def create
    if item.save
      flash[:success] = t 'items.create_success', item: item.name
      redirect_to items_path
    else
      flash.now[:danger] = t 'helpers.form_error'
      flash.now[:errors] = item.errors
      render 'new'
    end
  end

  def update
    if item.save
      flash[:success] = t 'items.update_success', item: item.name
      redirect_to items_path
    else
      flash.now[:danger] = t 'helpers.form_error'
      flash.now[:errors] = item.errors
      render 'edit'
    end
  end

  def destroy
    flash[:success] = t 'items.destroy_success', item: item.name
    redirect_to items_path
  end

  private
    def item_params
      params.require(:item).permit(:name, :description, :group_id)
    end
end
