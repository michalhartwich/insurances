class MaterialPoliciesController < ApplicationController
  expose(:policy, model: :MaterialPolicy, attributes: :policy_params)

  def index
    @policies = MaterialPolicy.all
  end

  def new
    prepare_hints
    @installments = {}
  end

  def create
    policy.items << Item.where(id: params[:material_policy][:items])
    if policy.save
      installments = JSON.parse(params[:installments])
      installments.each do |inst|
        inst[:instable] = policy
        Installment.create(inst)
      end
      flash[:success] = t 'material_policies.create_success', policy: policy.number
      redirect_to material_policies_path
    else
      flash.now[:danger] = t 'helpers.form_error'
      flash.now[:errors] = policy.errors
      render 'new'
    end
  end

  def show
    prepare_hints
    @installments = Installment.where(instable_id: policy.id)
  end

  def edit
    prepare_hints
    @items = Item.where(group_id: policy.group_id)
    @installments = Installment.where(instable_id: policy.id)
  end

  def update
    installments = JSON.parse(params[:installments])
    if policy.save
      Installment.where(instable_id: policy.id).destroy_all
      installments = JSON.parse(params[:installments])
      installments.each do |inst|
        inst[:instable] = policy
        Installment.create(inst)
      end
      flash[:success] = t 'material_policies.update_success', policy: policy.number
      redirect_to material_policies_path
    else
      flash.now[:danger] = t 'helpers.form_error'
      flash.now[:errors] = policy.errors
      render 'edit'
    end
  end

  def destroy
    MaterialPolicy.destroy(policy)
    flash[:success] = t 'material_policies.destroy_success', policy: policy.number
    redirect_to material_policies_path
  end

  private
    def policy_params
      params.require(:material_policy).permit(:client_id, :group_id, :items, :sign_date, :begin_date, 
        :expire_date, :number, :sum, :contribution, :comments)
    end

    def prepare_hints_for(collection)
      hints = []
      collection.each do |i|
        hints << i.to_hint
      end
      hints.collect!{|h| [h[:hint], h[:id]]}
    end

    def prepare_hints
      clients = Client.all
      @hints = prepare_hints_for clients
      groups = Group.all
      @group_hints = prepare_hints_for groups
      items = Item.all
      @item_hints = prepare_hints_for items
    end
end
