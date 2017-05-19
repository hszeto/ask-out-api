describe User do
  let!( :user   ){ create :user }
  let!( :user2  ){ create :user, email: "user@examples.com" }

  specify 'create' do
    expect( User.count ).to eq 2
  end

  specify 'read' do
    expect( User.first.email ).to eq "tester@examples.com"
  end
end