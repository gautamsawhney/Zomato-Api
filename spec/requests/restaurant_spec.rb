require 'rails_helper'

  context "json API" do

    describe "Create" do

      let(:user) { FactoryGirl.create :user } #create
      before(:each) do
        headers = { "CONTENT_TYPE" => "application/json" } #create
      @restaurant_params = FactoryGirl.build(:restaurant, user: user).attributes
        post "/login", '{ "user": { "email": "'+user.email+'", "password": "12345678" } }', headers
      end

      context "with valid attributes" do
        it "should create the restaurant" do
          expect { post "/api/v1/restaurants?auth_token=#{user.authtokens.first.token}", restaurant: @restaurant_params, format: :json }.to change(Restaurant, :count).by(1)
        end

        it 'responds with 201' do
          post "/api/v1/restaurants?auth_token=#{user.authtokens.first.token}", restaurant: @restaurant_params, format: :json
          expect(response).to have_http_status(201)
        end
      end

      context 'with invalid attributes' do
       
        it 'does not create the restaurant' do
          restaurant = FactoryGirl.build(:restaurant).attributes.symbolize_keys
          restaurant[:name] = ""
          expect { post "/api/v1/restaurants?auth_token=#{user.authtokens.first.token}", restaurant: restaurant, format: :json }.to_not change(Restaurant, :count)
        end

        it 'responds with 422' do
          restaurant = FactoryGirl.build(:restaurant).attributes.symbolize_keys
          restaurant[:name] = ""
          post "/api/v1/restaurants?auth_token=#{user.authtokens.first.token}",   restaurant:   restaurant, format: :json
          expect(response).to have_http_status(422)
        end
      end

    end  


    describe "Index" do 

      let(:user) { FactoryGirl.create :user } #index
      before(:each) do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/login", '{ "user": { "email": "'+user.email+'", "password": "12345678" } }', headers
        3.times { FactoryGirl.create :restaurant}
      end

      it "should fetch the correct number of restaurants" do
        get "/api/v1/restaurants?auth_token=#{user.authtokens.first.token}", page: 1, per: 2
        expect(json_response.count == 2).to eql(true)
      end

      it "should fetch the correct restaurants" do
        get "/api/v1/restaurants?auth_token=#{user.authtokens.first.token}", page: 1, per: 2
        json_response1 = json_response.clone
        get "/api/v1/restaurants?auth_token=#{user.authtokens.first.token}", page: 2, per: 2
        json_response2 = json_response.clone
        expect(json_response1.collect { |j1| j1['id'] } + json_response2.collect { |j2| j2['id'] }) .to eq(Restaurant.all.collect(&:id))
      end
      
      it "responds with 200" do
        get "/api/v1/restaurants?auth_token=#{user.authtokens.first.token}", format: :json
        expect(response).to have_http_status(200)
      end

    end

    describe "Show" do 

      let(:user) { FactoryGirl.create :user } #show
      before(:each) do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/login", '{ "user": { "email": "'+user.email+'", "password": "12345678" } }', headers
        @restaurant = FactoryGirl.create :restaurant
      end

      it "should fetch the required restaurant" do
        get "/api/v1/restaurants/#{@restaurant.id}?auth_token=#{user.authtokens.first.token}", format: :json
        expect(json_response['id']).to eql(@restaurant.id)
      end
      
      it "responds with 200" do
        get "/api/v1/restaurants/#{@restaurant.id}?auth_token=#{user.authtokens.first.token}", format: :json
        expect(response).to have_http_status(200)
      end
    end

    describe "Destroy" do 

      let(:user) { FactoryGirl.create :user } #destroy
      before(:each) do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/login", '{ "user": { "email": "'+user.email+'", "password": "12345678" } }', headers
        @restaurant = FactoryGirl.create :restaurant
      end

      it "should delete the required restaurant" do
        delete "/api/v1/restaurants/#{@restaurant.id}?auth_token=#{user.authtokens.first.token}", format: :json
        expect(response.body.empty?).to eql(true)
      end

      it "responds with 204" do
        delete "/api/v1/restaurants/#{@restaurant.id}?auth_token=#{user.authtokens.first.token}", format: :json
        expect(response).to have_http_status(204)
      end

    end

    describe "Update" do 

      let(:user) { FactoryGirl.create :user } #update
      before(:each) do
        headers = { "CONTENT_TYPE" => "application/json" }
        post "/login", '{ "user": { "email": "'+user.email+'", "password": "12345678" } }', headers
        @restaurant = FactoryGirl.create :restaurant
      end

      context "with valid attributes" do
        it "should update the restaurant" do
          restaurant = FactoryGirl.attributes_for(:restaurant)
          restaurant[:name] = "asdfghj"
          put "/api/v1/restaurants/#{@restaurant.id}?auth_token=#{user.authtokens.first.token}", restaurant: restaurant, format: :json
          @restaurant.reload
          expect(@restaurant.name).to eq("asdfghj")
        end

        it 'responds with 200' do
          restaurant = FactoryGirl.attributes_for(:restaurant)
          restaurant[:name] = "asdfghj"
          put "/api/v1/restaurants/#{@restaurant.id}?auth_token=#{user.authtokens.first.token}", restaurant: restaurant, format: :json
          @restaurant.reload
          expect(response).to have_http_status(200)
        end
      end

      context 'with invalid attributes' do

        it 'does not update the restaurant' do
          restaurant = FactoryGirl.attributes_for(:restaurant)
          restaurant[:name] = ""
          put "/api/v1/restaurants/#{@restaurant.id}?auth_token=#{user.authtokens.first.token}", restaurant: restaurant, format: :json
          @restaurant.reload
          expect(@restaurant.name ).not_to be_empty  
        end

        it 'responds with 422' do
          restaurant = FactoryGirl.attributes_for(:restaurant)
          restaurant[:name] = ""
          put "/api/v1/restaurants/#{@restaurant.id}?auth_token=#{user.authtokens.first.token}", restaurant: restaurant, format: :json
          @restaurant.reload
          expect(response).to have_http_status(422)
        end

      end

    end
  end


