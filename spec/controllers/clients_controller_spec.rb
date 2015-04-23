require 'rails_helper'

RSpec.describe ClientsController, :type => :controller do
  let(:user) {create(:user)}

  before {sign_in user}

  describe '#index' do
    render_views

    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'displays clients on view' do
      get :index
      expect(response.body).to match(/Klienci/)
    end
  end

  describe '#show' do
    render_views
    subject{ create(:client)}
    before {get :show, id: subject}

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'exposes client' do
      expect(assigns(:client)).to eq(subject)
    end

    it 'displays client details' do
      fullname = subject.full_name
      expect(response.body).to match(/#{fullname}/)
    end
  end

  describe '#create' do
    context 'with valid attributes' do
      subject{ attributes_for(:client) }

      it 'creates a new client' do
        expect{ post :create, client: subject }.to change(Client,:count).by(1)
      end
    end

    context 'with invalid attributes' do
      subject { attributes_for(:client, name: nil) }

      it 'does not create a new client' do
        expect { post :create, client: subject }.to_not change(Client, :count)
      end
    end
  end

  describe '#update' do
    let!(:client) { create(:client, name: 'John') }

    it 'exposes client' do
      put :update, id: client, client: client.attributes
      expect(assigns(:client)).to eq(client)
    end

    context 'valid attributes' do
      it "changes client's data" do
        put :update, id: client, client: attributes_for(:client, name: 'Peter')
        client.reload
        expect(client.name).to eq('Peter')
      end 
    end

    context 'invalid attributes' do
      it "does not change client's data" do 
        put :update, id: client, client: attributes_for(:client, name: nil)
        client.reload
        expect(client.name).to eq 'John'
      end
    end

  end

end
