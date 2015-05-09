class MaterialPoliciesController < ApplicationController
  expose(:policy, model: :MaterialPolicy, attributes: :policy_params)

  def initialize
    super
    @clients = Client.all
    @hints = []
    @clients.each do |client|
      @hints.push(client.to_hint)
    end
    @groups = Group.all
    @items = Item.all
    # @installments = Installment.where(instable_id: policy.id)
  end

  def index
    @policies = MaterialPolicy.all
  end

  def new
    @clients = Client.all
    @hints = []
    @clients.each do |client|
      @hints.push(client.to_hint)
    end
    @groups = Group.all
    @items = Item.all
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
    @clients = Client.all
    @hints = []
    @clients.each do |client|
      @hints.push(client.to_hint)
    end
    @groups = Group.all
    @items = Item.where(group_id: policy.group_id)
    @installments = Installment.where(instable_id: policy.id)
  end

  def edit
    @clients = Client.all
    @hints = []
    @clients.each do |client|
      @hints.push(client.to_hint)
    end
    @groups = Group.all
    @items = Item.where(group_id: policy.group_id)
    @installments = Installment.where(instable_id: policy.id)
  end

  def update
    installments = JSON.parse(params[:installments])
    puts YAML::dump(installments)
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
end
