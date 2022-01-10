class PostsController < ApplicationController
  skip_before_action :require_login, only: %i(index)
  before_action :set_post, only: %i(edit update destroy)

  def index
    @posts = 
    if current_user
      #フォローしているユーザーの投稿のみ表示
      current_user.feed.includes(:user).page(params[:page]).order(created_at: :desc)
    else
      #全ての投稿表示
      Post.all.includes(:user).page(params[:page]).order(created_at: :desc)
    end
    
    @users = User.recent(5)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:user).order(created_at: :desc)
    @comment = Comment.new
    @like = Like.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, flash: {success: "投稿に成功しました。"}
    else
      flash.now[:danger] = "投稿に失敗しました。"
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, flash: {success: "投稿情報を更新しました。"}
    else
      flash.now[:danger] = "投稿情報の更新に失敗しました。"
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, flash: {warning: "投稿を削除しました。"}
  end

  private

  def post_params
    params.require(:post).permit(:content, images: [])
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end
end
