class InvitesController < ApplicationController
  before_filter :get_idea, :only => [:new, :create]
  layout :false

  def new
    @invite = @idea.invites.new
  end

  def create
    @invite = @idea.invites.new(params[:invite])
    @invite.user = current_user
    respond_to do |wants|
      if added_member || @invite.save
        @sections = @idea.sections.all
        wants.html {
          render :json => {:list => render_to_string(:partial => 'members/list', :locals => {:idea => @idea}), :left_nav => render_to_string(:partial => 'layouts/left_nav')} if request.xhr?
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

    redirect_to idea_members_path(@invite.idea), :notice => "Your invitation to #{@invite.email} has been rescinded." 
  end

  def accept
    @invite = Invite.find_by_token(params[:id])
    if @invite.nil?
      flash[:error] = "Sorry, this invitation code cannot be found." 
      redirect_to root_url 
    elsif @invite.expired? 
      flash[:error] = "Sorry, this invitation has expired.  Please contact #{@invite.name} to request a new invitation to the idea."
      redirect_to root_url
    elsif @invite
      session[:invite_id] = @invite.id
      if User.find_by_email(@invite.email) 
        flash[:notice] = "To accept #{@invite.user.name}'s invitation to #{@invite.idea.name}, please login to your GetIdeated account below."
        redirect_to new_user_session_path
      else
        flash[:notice] = "To accept #{@invite.user.name}'s invitation to #{@invite.idea.name}, please create an account below."
        redirect_to new_user_registration_path
      end
    end
  end

  def resend
    @invite = Invite.find_by_id(params[:id])
    if @invite
      @invite.resend
      redirect_to idea_members_path(@invite.idea), :notice => "Your invitation to #{@invite.email} has been resent" 
    else
      redirect_to ideas_path, :error => "Could not resend that invitation" 
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
