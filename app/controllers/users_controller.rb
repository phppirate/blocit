class UsersController < ApplicationController
  #include Bloccit::Cache
  def index
    @users = User.top_rated.paginate(page: params[:page], per_page: 10)
  end
  def show
    @user = User.find(params[:id])
    @posts = @user.posts.visible_to(current_user)
    @favorites = $redis.smembers(current_user.id)
    @favorite_posts = []

    @favorites.each do |f|
      @favorite_posts << Post.find(f)
    end
    @favorite_posts
  end

end