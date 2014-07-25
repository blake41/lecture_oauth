class WhateverController < ApplicationController

  def make_link
    
  end

  def get_tweets
    id = User.last.id
    @tweets = Requester.new(id).make_request
  end

  def receive_callback_create_user
    binding.pry
    user = User.create(:token => token, :secret => secret)
    redirect_to "/make_link"
  end


  def auth_hash
    request.env['omniauth.auth']
  end

  def token
    auth_hash["credentials"].token
  end

  def secret
    auth_hash["credentials"].secret
  end

end
