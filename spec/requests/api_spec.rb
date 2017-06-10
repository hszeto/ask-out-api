describe 'API' do
  # let(){ }
  before do
    stub_aws_cognito_with_expired_or_no_token
  end

  it 'Fail by no token' do
    get '/api/auth'

    expect( last_response.status ).to eq 401
  end

  it 'Fail by expired token' do
    header "AUTHORIZATION", "Expired_Cognito_AWS_Token"
    get '/api/auth'

    expect( last_response.status ).to eq 401
  end
end

describe "API" do
  before do
    stub_aws_cognito
    allow_any_instance_of( AwsAuth )
      .to receive(:get_cognito_user)
      .and_return( JSON[ {email: "testy@example.com"}.to_json ] )

  end

  it 'Success' do
    header "AUTHORIZATION", "Cognito_AWS_Token"
    get '/api/auth'

    expect( last_response.status ).to eq 200
    expect( JSON.parse(last_response.body)['email'] ).to eq "testy@example.com"
  end
end
