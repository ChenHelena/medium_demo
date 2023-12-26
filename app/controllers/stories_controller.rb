class StoriesController < ApplicationController
  before_action :authenticate_user!, except: [:like, :unlike]
  before_action :find_story, only: [:edit, :destroy, :update]
  skip_before_action :verify_authenticity_token, only: [:like, :unlike]

  def index 
    @stories = current_user.stories.order(created_at: :desc)
  end
  def new
    @story = current_user.stories.new
  end
  def create
    @story = current_user.stories.new(story_params)
    # @story.status = 'published' if params[:publish] 
    @story.publish! if params[:publish] 
    if @story.save
      if params[:publish]
        redirect_to stories_path, notice:'發布成功'
      else
        redirect_to edit_story_path(@story), notice:'儲存草稿'
      end
    else
      render :new
    end
  end
  
  
  def edit
  end

  def destroy
    @story.destroy
    redirect_to stories_path,notice:'刪除成功'
  end

  def update 
    if @story.update(story_params)
      case
      when params[:publish] 
        @story.publish!
        redirect_to stories_path, notice:'發布成功'
      when params[:unpublish]
        @story.unpublish!
        redirect_to stories_path, notice:'下架成功'
      else
        redirect_to edit_story_path(@story), notice:'儲存草稿'
      end
    else
      render :edit
    end
  end

  def like
    @story = Story.friendly.find(params[:id])
    like = current_user.likes.find_or_initialize_by(story: @story)
    unless user_signed_in?
      render json: { status: '您尚未登入' }
      return
    end
    
    if like.persisted?
      like.destroy
      is_liked = false
    else
      like.save
      is_liked = true
    end
    
    render json: { likes_count: @story.likes.count, is_liked: is_liked }
  end


  private
  def find_story
    @story = current_user.stories.friendly.find(params[:id])
  end
  def story_params
    params.require(:story).permit(:title, :content, :cover_image)
  end
end
