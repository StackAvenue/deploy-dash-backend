require 'spec_helper'

RSpec.describe Api::V1::GithubOauthController, type: :controller do
  describe "authorise_user" do
    it "returns a 200" do
      git_response = {
        status: 200,
        data: [login: "login", git_id: 342425 ]
      }
      stub_request(:get, ENV["GIT_OAUTH_LOGIN_URL"]).
      to_return(status: 200, body: git_response.to_json)
      expect(git_response).to be_kind_of(Hash)
      expect(git_response).to have_key(:status)
      expect(git_response).to have_key(:data)
    end

    it 'returns a 401' do
      git_response = {
        status:  401,
        message: 'empty or invalid code'
      }
      expect(git_response).to have_key(:status)
      expect(git_response).to have_key(:message)
    end
  end
end