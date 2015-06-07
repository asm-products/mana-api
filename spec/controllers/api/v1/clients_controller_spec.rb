require 'rails_helper'

RSpec.describe Api::V1::ClientsController, type: :controller do

	context 'with valid client' do
		let!(:client){ create(:client) }

    context '#index' do
      before(:each) do
        get :index
      end
			it 'lists clients' do
				expect(response).to have_http_status :ok
				expect(response.body).to include "clients"
			end
			it 'excludes attributes' do
        expect(response.body).to_not include "id"
        expect(response.body).to_not include "created_at"
        expect(response.body).to_not include "updated_at"
			end
    end

    context '#show' do
      before(:each) do
        get :show, id: client.slug
      end
      it 'shows a client' do
        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body)["client"]["slug"]).to eq client.slug
      end
      it 'excludes attributes' do
				expect(response.body).to_not include "id"
				expect(response.body).to_not include "created_at"
				expect(response.body).to_not include "updated_at"
      end
      it 'only accepts slug as id param' do
        get :show, {id: client.id}
        expect(response.body).to eq "null"
      end
    end

    context '#create' do
      before(:each) do
				post :create, { name: "testClient", slug: "abcd" }
      end
      it 'creates clients' do
        expect(response).to have_http_status :ok
        expect(Client.find_by(slug: "abcd")).to_not eq nil
      end
      it 'returns created client' do
        expect(JSON.parse(response.body)["client"]["slug"]).to eq "abcd"
      end
    end

    context '#update' do
      it 'updates clients' do
				post :update, id: client.slug, name: "updatedName"
        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body)["client"]["name"]).to eq "updatedName"
      end
    end

    context '#destroy' do
      it 'destroys clients' do
        delete :destroy, id: client.slug
        expect(response).to have_http_status :ok
        expect(JSON.parse(response.body)["message"]).to eq "Client deleted."
        expect(Client.find_by(slug: client.slug)).to eq nil
      end
    end

  end

  context 'with invalid client' do
    let!(:client) { create(:client) }
    it '#create returns errors' do
      post :create, { name:"", slug:"" }
      expect(response).to have_http_status :not_acceptable
      expect(JSON.parse(response.body)["errors"]).to_not eq nil
    end
    it '#update returns errors' do
			post :update, id: client.slug, name: "", slug: ""
      expect(response).to have_http_status :not_acceptable
      expect(JSON.parse(response.body)["errors"]).to_not eq nil
    end
  end
end
