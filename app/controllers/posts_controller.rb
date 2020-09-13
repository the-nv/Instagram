class PostsController < ApplicationController
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!
    before_action :owned_post, only: [:edit, :update, :destroy]

    def index
        @posts = nil

        @per_page = 2
        @fetch_from = params.fetch(:fetch_from, 0)

        @posts = Post.offset(@fetch_from).limit(@per_page).order('created_at DESC')

        respond_to do |format|
            format.html 
            format.js
        end
    end

    def timeline
        @posts = nil
        
        @tper_page = 2
        @fetch_from = params.fetch(:fetch_from, 0)

        @posts = Post.offset(@fetch_from).limit(@per_page).where(:user_id => current_user.id).order('created_at DESC')

        respond_to do |format|
            format.html 
            format.js
        end
    end

    def show
    end

    def new
        @post = current_user.posts.build
    end

    def edit
    end

    def create
        @post = current_user.posts.build(post_params)

        if @post.save
            redirect_to posts_path
        else
            render :new
        end
    end

    def update
        if @post.update(post_params)
            redirect_to post_path(@post)
        else
            render :edit
        end
    end

    def destroy
        @post.destroy

        redirect_to posts_path
    end

    private
        def set_post
            @post = Post.find(params[:id])
        end

        def post_params
            params.require(:post).permit(:image, :caption)
        end

        def owned_post
            unless current_user == @post.user
                redirect_to root_path
            end
        end
end
