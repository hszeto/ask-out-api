class ApiController < ApplicationController
  before_action :validate_jwt

  def auth
    render json: { data: "hello auth" }.to_json
  end

  private
  def validate_jwt
    if request.headers[ 'X-Api-Authorization' ] != ENV[ 'API_AUTHORIZATION' ]
      render status: 401, json: {}.to_json
    end
  end
end