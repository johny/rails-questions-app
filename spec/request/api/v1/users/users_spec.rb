# spec/requests/api/events/events_spec.rb

require 'spec_helper'

describe 'GET /api/users/:id' do
  it 'returns an user by :id' do
    user = create!(:user)

    get "/api/users/#{user.id}"

    expect(JSON.parse(response.body)).to eq({
      'id' => user.id,
      'name' => user.name
    })
  end
end