require 'rails_helper'

RSpec.describe "Homes", type: :request do
  describe "#home" do
    example "リクエストに成功すること" do
      get root_path
      expect(response).to have_http_status(:success)
    end
  end
end
