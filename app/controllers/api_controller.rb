class ApiController < ApplicationController
  include AwsAuth
  before_action :validate_token

  def auth
    render json: { email: @email }.to_json
  end


  private

  def client_token
    return request.headers[ 'HTTP_AUTHORIZATION' ] if request.headers[ 'HTTP_AUTHORIZATION' ].present?
  end

  def validate_token
    if client_token.blank?
      render status: 401, json: {}.to_json
      return
    end

    aws_response = get_cognito_user(client_token)

    if aws_response['error'].present?
      render status: 401, json: aws_response.to_json
      return
    end

    set_user( aws_response['email'] )
  end

  def set_user(email)
    @email = email
  end
end