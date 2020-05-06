class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    def index
        @posts = Post.all.order(created_at: :desc)
    end 

    def show
        @post = Post.find(params[:id])
        @comment = Comment.new
        @comments = @post.comments.order(created_at: :desc)
    end 

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(params.require(:post).permit(:title, :body, :image)) 
        @post.user = @current_user
        if @post.save  
            redirect_to posts_path  
        else 
            render :new 
	    end
    end 

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
    end

    def edit
        @post = Post.find(params[:id])
    end 

    def update 
        @post = Post.find(params[:id])
        if @post.update(params.require(:post).permit(:title, :body, :image))
            redirect_to post_path(@post) 
        else 
            render :edit
	    end
    end

end
