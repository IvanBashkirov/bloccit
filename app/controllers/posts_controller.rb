class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts.each_with_index do |post, ind|
      post.title = "SPAM" if ind%5 == 0
    end
  end

  def show
  end

  def new
  end

  def edit
  end
end
