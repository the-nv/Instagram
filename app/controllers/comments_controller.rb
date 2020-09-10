class CommentsController < ApplicationController
    before_action :set_post

    def new

    end

    def create
        @comment = @post.comments.build(comment_params)
        @comment.user_id = current_user.id

        if @comment.save
            redirect_back(fallback_location:"/")
        else
            render root_path
        end
    end

    def destroy
        @comment = @post.comments.find(params[:id])

        @comment.destroy

        redirect_to root_path
    end

    private
        def comment_params
            params.require(:comment).permit(:content)
        end

        def set_post
            @post = Post.find(params[:post_id])
        end
end
