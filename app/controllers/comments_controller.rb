class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        @post = Post.find params[:post_id]
        comment_params = params.require(:comment).permit(:body)
        @comment = Comment.new comment_params
        @comment.user = @current_user
        @comment.post = @post
        @comment.save
        redirect_to post_path(@post), notice: 'Comment created!'
    end

    def destroy
        @comment = Comment.find params[:id]
        @comment.destroy 
        redirect_to post_path(@comment.post)
    end
end
