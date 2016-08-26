require 'rails_helper'

describe User do
  before(:each) do
    @user = User.new
    @user.username = 'John'
  end

  it 'should have valid username and password' do
    users = [{username: 'user', password: 'password'},
             {username: 'User1992', password: 'password'},
             {username: '  UserName', password: 'password'},
             {username: 'UseR_  ', password: '123456'}]
    users.each { |user| expect(User.create(user)).to be_valid }
  end

  it "shouldn't have any symbols in username except numbers, letters and _" do
    symbols = %w(~ ! @ # $ % ^ & * ( ) { } - + = / | \\)
    users = [{username: 'user@mail.ru', password: 'password'}]
    symbols.each { |symbol| users << { username: 'user' + symbol, password: '123456' } }
    users.each { |user| expect(User.create(user)).to be_invalid }
  end

  it 'should have username' do
    expect(User.create({ username: '', password: '123456' })).to be_invalid
  end

  it 'should have unique and case insensitive username' do
    User.create({ username: 'username', password: '123456' })
    expect(User.create({ username: 'UsErNamE', password: '123456' })).to be_invalid
  end

  it 'should have username with maximum 30 characters' do
    expect(User.create({ username: 'username12username12username12', password: '123456' })).to be_valid
    expect(User.create({ username: 'username12username12username123', password: '123456' })).to be_invalid
  end

  it 'should have password with minimum 6 characters' do
    expect(User.create({ username: 'user', password: '123' })).to be_invalid
    expect(User.create({ username: 'user', password: '12345' })).to be_invalid
  end

  it 'should have password with maximum 50 characters' do
    expect(User.create({ username: 'user', password: 'ABCDEFGHIJabcdefghij!@#$%^&*()1234567890ABCDEFGHIJ' })).to be_valid
    expect(User.create({ username: 'user', password: 'ABCDEFGHIJabcdefghij!@#$%^&*()1234567890ABCDEFGHIJ1' })).to be_invalid
  end
end