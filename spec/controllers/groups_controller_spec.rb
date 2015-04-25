require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:user) {create(:user)}

  before {sign_in user}

  describe '#index' do
    render_views

    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'displays groups on view' do
      get :index
      expect(response.body).to match(/Grupy/)
    end
  end

  describe '#show' do
    render_views
    subject{ create(:group)}
    before {get :show, id: subject}

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'exposes group' do
      expect(assigns(:group)).to eq(subject)
    end

    it 'displays group details' do
      expect(response.body).to match(/#{subject.name}/)
    end
  end

  describe '#create' do
    context 'with valid attributes' do
      subject{ attributes_for(:group) }

      it 'creates a new group' do
        expect{ post :create, group: subject }.to change(Group,:count).by(1)
      end
    end

    context 'with invalid attributes' do
      subject { attributes_for(:group, name: nil) }

      it 'does not create a new group' do
        expect { post :create, group: subject }.to_not change(Group, :count)
      end
    end
  end

  describe '#update' do
    let!(:group) { create(:group, name: 'Groupname') }

    it 'exposes group' do
      put :update, id: group, group: group.attributes
      expect(assigns(:group)).to eq(group)
    end

    context 'valid attributes' do
      it "changes group's data" do
        put :update, id: group, group: attributes_for(:group, name: 'Groupname 2')
        group.reload
        expect(group.name).to eq('Groupname 2')
      end 
    end 

    context 'invalid attributes' do
      it "does not change group's data" do 
        put :update, id: group, group: attributes_for(:group, name: nil)
        group.reload
        expect(group.name).to eq('Groupname')
      end
    end
  end

  describe '#destroy' do
    let!(:group) { create(:group) }                       
    it 'deletes group' do
      expect{ delete :destroy, id: group }.to change(Group, :count).by(-1)
    end
  end

end
