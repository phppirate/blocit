class FavoritesController < ApplicationController

  #include Bloccit::Cache
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    authorize! :create, Favorite, message: "You cannot do that"

    $redis.sadd(current_user.id, @post.id)

    favorite = current_user.favorites.create(post: @post)
    if favorite.valid?
      flash[:notice] = "Favorited post"
      redirect_to [@topic, @post]
    else
      flash[:error] = "Unable to add favorite. Please try again."
      redirect_to [@topic, @post]
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @favorite = current_user.favorites.find(params[:id])
    authorize! :create, Favorite, message: "You cannot do that"

    $redis.srem(current_user.id, params[:post_id])

    if @favorite.destroy
      flash[:notice] = "Removed favorite."
      redirect_to [@topic, @post]
    else
      flash[:error] = "Unable to remove favorite. Please try again."
      redirect_to [@topic, @post]
    end
  end
end