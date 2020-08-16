require 'rails_helper'

RSpec.describe "CreditCards", type: :request do

  describe "GET /new" do
    it "returns http success" do
      get "/credit_card/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/credit_card/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/credit_card/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/credit_card/delete"
      expect(response).to have_http_status(:success)
    end
  end

end
