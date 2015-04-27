require 'rails_helper'

RSpec.describe ItemsController, type: :controller do

  let(:user) {create(:user)}

  before {sign_in user}

  describe '#index' do
    render_views

    it 'responds successfully with an HTTP 200 status code' do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'displays items on view' do
      get :index
      expect(response.body).to match(/Przedmioty/)
    end
  end

  describe '#show' do
    render_views
    subject{ create(:item, group: create(:group))}
    before {get :show, id: subject}

    it 'responds successfully with an HTTP 200 status code' do
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it 'exposes item' do
      expect(assigns(:item)).to eq(subject)
    end

    it 'displays item details' do
      expect(response.body).to match(/#{subject.name}/)
    end
  end

  describe '#create' do
    let!(:group) {create(:group)}
    context 'with valid attributes' do
      subject{ attributes_for(:item, group_id: group.id) }

      it 'creates a new item' do
        expect{ post :create, item: subject }.to change(Item,:count).by(1)
      end
    end

    context 'with invalid attributes' do
      subject { attributes_for(:item, name: nil, group: create(:group)) }

      it 'does not create a new item' do
        expect { post :create, item: subject }.to_not change(Item, :count)
      end
    end
  end

  describe '#update' do
    let!(:item) { create(:item, name: 'Itemname', group: create(:group)) }

    it 'exposes item' do
      put :update, id: item, item: item.attributes
      expect(assigns(:item)).to eq(item)
    end

    context 'valid attributes' do
      it "changes item's data" do
        put :update, id: item, item: attributes_for(:item, name: 'Itemname 2')
        item.reload
        expect(item.name).to eq('Itemname 2')
      end 
    end 

    context 'invalid attributes' do
      it "does not change item's data" do 
        put :update, id: item, item: attributes_for(:item, name: nil)
        item.reload
        expect(item.name).to eq('Itemname')
      end
    end

    describe '#destroy' do
      let!(:item) { create(:item, group: create(:group)) }                       
      it 'deletes item' do
        expect{ delete :destroy, id: item }.to change(Item, :count).by(-1)
      end
    end
  end

end
