describe User do

  before(:each) { @user = User.new(username: 'testname', email: 'user@example.com') }

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:username) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:username) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:username)}

  it "#email returns a string" do
    expect(@user.email).to match 'user@example.com'
  end

end
