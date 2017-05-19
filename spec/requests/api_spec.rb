describe 'API' do
  # let(){  }

  describe 'Verify JWT' do
    # let(){  }

    specify 'Success' do
      header 'Accept', 'application/json'
      header 'X-Api-Authorization', ENV[ 'API_AUTHORIZATION' ]
      get '/api/auth'

      expect( last_response.status ).to eq 200
      expect( JSON.parse(last_response.body)['data'] ).to eq "hello auth"
    end
  end
end