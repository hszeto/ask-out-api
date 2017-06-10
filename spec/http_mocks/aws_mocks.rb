def stub_aws_cognito

  WebMock.stub_request(:post, "https://cognito-idp.us-west-2.amazonaws.com/")
         .to_return(:status => 200,
                    :body => {
                              username: "testy@example.com",
                              user_attributes: [
                                  {
                                    name: "sub",
                                    value: "cbb6d7f8-3d37-4d1f-8648-ca61a4beee26"
                                  },
                                  {
                                    name: "email_verified",
                                    value: "true"
                                  },
                                  {
                                    name: "email",
                                    value: "testy@example.com"
                                  }
                              ]
                              }.to_json,
                    :headers => { 'Content-Type' => 'application/json' })
end

def stub_aws_cognito_with_expired_or_no_token
  WebMock.stub_request(:post, "https://cognito-idp.us-west-2.amazonaws.com/")
         .to_return(:status => 401)
end