class TweetsController < ApplicationController
  def index
    tweets = Tweet.all.order(id: :desc)
    page_size = 20

    if params[:last_loaded_id].presence
      tweets = tweets.where("id < :last_id", last_id: params[:last_loaded_id]).limit(page_size)
    end

    if params[:user_username].presence
      user = User.by_username(params[:user_username]).first
      tweets = tweets.where(user: user) if user
    end
    
    render json: tweets
  end
end
