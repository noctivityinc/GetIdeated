class InvitesController < ApplicationController
  before_filter :get_idea, :except => :destroy
  layout :false

  def new
    @invite = @idea.invites.new
  end

  def create
    @invite = @idea.invites.new(params[:invite])
    @invite.user = current_user
    respond_to do |wants|
      if added_member || @invite.save
        wants.html {
          render :partial => 'members/list', :locals => {:idea => @idea}  if request.xhr?
        }
      else
        wants.html {
          render :new, :status => "30"
        }
      end
    end
  end

  def destroy
    @invite = Invite.find(params[:id])
    @invite.destroy

    respond_to do |wants|
      wants.html {
        render :partial => 'members/list', :locals => {:idea => @invite.idea}  if request.xhr?
      }
    end
  end

  private

  def get_idea
    @idea = Idea.find_by_id(params[:idea_id])
    unless @idea
      respond_to do |wants|
        wants.html {
          if request.xhr?
            head :status =>  404
          else
            redirect_to root_url, :notice => "Idea could not be found"
          end
        }
      end
    end
  end

  def added_member
    user = User.find_by_email(params[:invite][:email]) unless params[:invite][:email].blank?
    if user 
      return @idea.members.create({:user_id => user.id, :can_edit => params[:invite][:can_edit]})
    else
      return false
    end
  end

end
