class ClientsController < ApplicationController

  expose(:client, attributes: :client_params)

  def index
    @clients = Client.all
  end

  def create
    if client.save
      flash[:success] = t 'clients.create_success'
      redirect_to clients_path
    else
      flash.now[:danger] = t 'helpers.form_error'
      flash.now[:errors] = client.errors
      render 'new'
    end
  end

  def destroy
    Client.destroy(client)
    flash[:success] = t 'clients.destroy_success', client: client.full_name
    redirect_to clients_path
  end

  def update
    if client.save
      redirect_to clients_path, success: 'dziala'
    else
      flash.now[:danger] = t 'helpers.form_error'
      flash.now[:errors] = client.errors
      render 'edit'
    end
  end

  def material_policies
    @policies = MaterialPolicy.where(client_id: client.id)
  end

  private
    def client_params
      params.require(:client).permit(:surname, :name, :company, :regon, :pesel,
        :telephone_number, :e_mail, :activity, :street, :city, :zip_code)
    end
end
