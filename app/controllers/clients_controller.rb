class ClientsController < ApplicationController



  def index
    @clients = Client.all
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      flash[:success] = t 'clients.create_success'
      redirect_to clients_path
    else
      flash.now[:danger] = t 'helpers.form_error'
      flash.now[:errors] = @client.errors
      render 'new'
    end
  end

  def destroy
    @client = Client.destroy(params[:id])
    flash[:success] = t 'clients.destroy_success', client: @client.full_name
    redirect_to clients_path
  end

  def edit
    @client = Client.find(params[:id])
  end

  def update
    @client = Client.find(params[:id])
    if @client.update_attributes(client_params)
      redirect_to clients_path, success: 'dziala'
    else
      flash.now[:danger] = t 'helpers.form_error'
      flash.now[:errors] = @client.errors
      render 'edit'
    end
  end

  private
    def client_params
      params.require(:client).permit(:surname, :name, :company, :REGON, :PESEL,
        :telephone_number, :e_mail, :activity, :street, :city, :zip_code)
    end
end
