class ItemsController < ApplicationController

  def initialize
    @groups = Group.all
    super
  end

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = t 'items.create_success', item: @item.name
      redirect_to items_path
    else
      flash.now[:danger] = t 'helpers.form_error'
      flash.now[:errors] = @item.errors
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      flash[:success] = t 'items.update_success', item: @item.name
      redirect_to items_path
    else
      flash.now[:danger] = t 'helpers.form_error'
      flash.now[:errors] = @item.errors
      render 'edit'
    end
  end

  def destroy
    @item = Item.destroy(params[:id])
    flash[:success] = t 'items.destroy_success', item: @item.name
    redirect_to items_path
  end

  private
    def item_params
      params.require(:item).permit(:name, :description, :group_id)
    end
end
