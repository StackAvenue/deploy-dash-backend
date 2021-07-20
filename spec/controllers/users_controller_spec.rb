# require 'spec_helper'
require "rails_helper"

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "user details" do
    it "GET user details returns status 200" do
      user = create(:user)
      user = user.as_json
      @request.headers['Authorization'] = user["access_token"]
      get :show
      expect(response).to have_http_status(200)
      expect(response.body).to include(user["access_token"])
    end

    it "GET user details returns status 200" do
      user = create(:user)
      user = user.as_json
      @request.headers['Authorization'] = "123456"
      get :show
      expect(response).to have_http_status(401)
      expect(response.body).to include("Invalid access token!!")
    end

    it "GET user details returns status 401" do
      user = create(:user)
      user = user.as_json
      get :show
      expect(response).to have_http_status(401)
      expect(response.body).to include("Empty Access token")
    end

    it "GET user repositories returns status 200" do
      user = create(:user)
      user = user.as_json
      git_response = {
        status: 200,
        data: [{"name": "name", "url": "https//git/repo/url"}]
      }
      allow(controller).to receive(:repositories).and_return(git_response)
      get :repositories
      expect(controller.repositories).to include(status: 200)
      expect(controller.repositories).to have_key(:data)
    end

    it "GET user repositories returns status 401" do
      user = create(:user)
      user = user.as_json
      git_response = {
        status: 401,
        message: "Empty Access token"
      }
      allow(controller).to receive(:repositories).and_return(git_response)
      get :repositories
      expect(controller.repositories).to include(status: 401)
      expect(controller.repositories).to include(message: "Empty Access token" )
    end

    it "GET user repositories returns status 500" do
      user = create(:user)
      user = user.as_json
      git_response = {
        status: 500,
        message: "Something went wrong"
      }
      allow(controller).to receive(:repositories).and_return(git_response)
      get :repositories
      expect(controller.repositories).to include(status: 500)
      expect(controller.repositories).to include(message: "Something went wrong" )
    end

    it "GET user branches returns status 200" do
      user = create(:user)
      user = user.as_json
      git_response = {
        status: 200,
        data: ['name': "master", 'full_name': "full_name", 'branch': 'branch']
      }
      allow(controller).to receive(:branches).and_return(git_response)
      get :branches
      expect(controller.branches).to include(status: 200)
      expect(controller.branches).to have_key(:data)
    end

    it "GET user branches returns status 401" do
      user = create(:user)
      user = user.as_json
      git_response = {
        status: 401,
        message: "Empty Access token"
      }
      allow(controller).to receive(:branches).and_return(git_response)
      get :branches
      expect(controller.branches).to include(status: 401)
      expect(controller.branches).to include(message: "Empty Access token")
    end

    it "GET user branches returns status 500" do
      user = create(:user)
      user = user.as_json
      git_response = {
        status: 500,
        message: "Something went wrong"
      }
      allow(controller).to receive(:branches).and_return(git_response)
      get :branches
      expect(controller.branches).to include(status: 500)
      expect(controller.branches).to include(message: "Something went wrong")
    end
  end
end
