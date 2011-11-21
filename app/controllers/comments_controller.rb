class CommentsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :get_association, :except => :destroy

  def create
    @comment = @record.comments.new(params[:comment])
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html {
          render @record.comments.all if request.xhr?
        }
        format.json { head :ok }
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  end


  def destroy
    @comment = Comment.find(params[:id])
    @record = @comment.commentable

    respond_to do |format|
      if @comment.destroy
        format.html {
          render @record.comments.all if request.xhr?
        }
        format.json { head :ok }
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    end
  end

  private

  def get_association
    @record = Idea.find_by_id(params[:idea_id]) if params[:idea_id]
    @record ||= Section.find_by_id(params[:section_id]) if params[:section_id]
    unless @record
      respond_to do |wants|
        wants.html {
          if request.xhr?
            head :status =>  404
          else
            redirect_to root_url, :notice => "Association could not be found"
          end
        }
      end
    end
  end

end
