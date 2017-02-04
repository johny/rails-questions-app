require 'spec_helper'

describe 'GET /api/users/:id' do

  it 'returns an user by :id' do

    user = create(:user)
    get "/api/users/#{user.id}"

    expect(JSON.parse(response.body)).to eq({
      'id' => user.id,
      'name' => user.name,
      'title' => user.title,
      'ranking_position' => user.ranking_position,
      'level' => user.level,
      'score' => user.score
    })
  end
end


describe 'POST /api/users' do

  it 'returns error message when validation failed' do

    post '/api/users',
      {user: {
        name: 'Test Tester'
        }}.to_json,
      { 'Content-Type' => 'application/json' }

    expect(JSON.parse(response.body)['message']).to eq('Validation failed')

  end

  it 'returns id of a created user' do

    post '/api/users',
      {
        user: {
          name: "Test Tester",
          email: "email@example.com",
          password: "securepassword1234"
        }
      }.to_json,
      { 'Content-Type' => 'application/json' }

    user = User.last

    expect(JSON.parse(response.body)).to eq({
      'id' => user.id,
      'name' => 'Test Tester',
      'token' => user.authentication_token
    })

  end

end