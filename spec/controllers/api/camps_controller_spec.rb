require 'rails_helper'

RSpec.describe Api::CampsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'returns the correct json for all camps' do
      camp_count = 10
      FactoryBot.create_list(:camp, camp_count)
      get :index
      parsed = JSON.parse(response.body)
      expect(parsed.count).to eq(camp_count)
    end
  end

  describe "GET #show" do
    before(:each) do
      @camp = FactoryBot.create(:camp)
      get :show, params: { id: @camp.id }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'return the right bootcamp JSON' do
      parsed = JSON.parse(response.body)
      expect(parsed['id']).to eq(@camp.id)
    end
  end

  describe "POST #create" do
    context 'with valid params' do
      bootcamp_name = 'DevPoint Labs'

      let(:valid_params) { 
        { "bootcamp" => 
          { 
            "name" => bootcamp_name, 
            "year_founded" => 2003, 
            "full_time_tuition_cost" => 10000, 
            "part_time_tuition_cost" => 7000 
          }
        } 
      }

      before(:each) do
        post :create, params: valid_params
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it 'returns the created bootcamps JSON' do
        parsed = JSON.parse(response.body)
        expect(parsed['name']).to eq(bootcamp_name)
    end
  end

  describe "GET #update" do
    it "returns http success" do
      get :update
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #destroy" do
    it "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
