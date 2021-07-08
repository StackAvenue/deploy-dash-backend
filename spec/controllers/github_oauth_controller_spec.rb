require 'spec_helper'
require "rails_helper"

RSpec.describe Api::V1::GithubOauthController, type: :controller do
  describe "GET authorise_user" do
    it "returns a 200" do
      request.headers["Authorization"] = "foo"
      
      expect(response).to have_http_status(:ok)
    end
  end
end