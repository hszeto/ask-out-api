describe 'API: validate_token with AWS Cognito' do
  # let(){ }
  context "no Cognito access token" do
    before do
      # stub AwsAuth get_cognito_user
      allow_any_instance_of( AwsAuth )
        .to receive(:get_cognito_user)
        .and_return( JSON[ {error: "1 validation error detected: Value at 'accessToken…isfy regular expression pattern: [A-Za-z0-9-_=.]+"}.to_json ] )
    end

    it 'response 401' do
      get '/api/auth'

      expect( last_response.status ).to eq 401
    end
  end

  context "expired Cognito access token" do
    before do
      # stub AwsAuth get_cognito_user
      allow_any_instance_of( AwsAuth )
        .to receive(:get_cognito_user)
        .and_return( JSON[ {error: "Access Token has expired"}.to_json ] )
    end

    it 'response 401' do
      header "AUTHORIZATION", "Expired_Cognito_AWS_Token"
      get '/api/auth'

      expect( last_response.status ).to eq 401
    end
  end

  context "valid Cognito access token" do
    before do
      # stub AwsAuth get_cognito_user
      allow_any_instance_of( AwsAuth )
        .to receive(:get_cognito_user)
        .and_return( JSON[ {email: "testy@example.com"}.to_json ] )
    end

    it 'response 200 and user email' do
      header "AUTHORIZATION", "Cognito_AWS_Token"
      get '/api/auth'

      expect( last_response.status ).to eq 200
      expect( JSON.parse(last_response.body)['email'] ).to eq "testy@example.com"
    end
  end
end
