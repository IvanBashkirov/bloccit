class PostsController < ApplicationController
  def index
    @posts = Post.all
    @posts.all.each_with_index do |post, ind|
      if ind%5 == 0
        post.title = "SPAM"
        post.save
      end
    end
  end

  def show
  end

  def new
  end

  def edit
  end
end
