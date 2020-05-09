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
        if can?(:crud, @comment)
            @comment.destroy 
            redirect_to post_path(@comment.post)
        else
            #head :unauthorized
            flash[:warning] = "You do not have permition to make this action"    
            redirect_to post_path(@comment.post)
        end
    end

    
end
