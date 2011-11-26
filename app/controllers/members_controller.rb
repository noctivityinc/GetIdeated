class MembersController < ApplicationController
  before_filter :get_idea, :get_sections, :set_breadcrumbs, :except => [:destroy] 
  before_filter :authenticate_access!, :except => [:destroy] 

  def index
    @members = @idea.members.all
    @invitations = @idea.invites.not_expired
    @invite = @idea.invites.new
  end

  def list
    @members = @idea.members.all
    @invitations = @idea.invites.not_expired
    @invite = @idea.invites.new
  end

  def create
    @member = @idea.members.new(params[:member])
    if @member.save
      redirect_to @member, :notice => "Successfully created member."
    else
      render :action => 'new'
    end
  end

  def destroy
    @member = Member.find(params[:id])
    if authenticate_access(@member.idea)
      @member.destroy
      MemberMailer.removed(@member).deliver 

      redirect_to idea_members_path(@member.idea), :notice => "#{@member.user.name} has been removed from this idea." 
    end
  end

  private

  def get_idea
    @idea = Idea.find_by_id(params[:idea_id])
    redirect_to root_url, :notice => "Idea could not be found" unless @idea
  end

  def get_sections
    @sections = @idea.sections.all
  end

  def authenticate_access!
    authenticate_access(@idea)
  end

  def authenticate_access(idea)
    if current_user.authorized_to_edit?(idea)
      return true
    else
      flash[:error] = 'You are not authorized to manage the members for this idea'
     return redirect_to ideas_path
    end 
  end

  def set_breadcrumbs
    add_breadcrumb "Ideas", ideas_path
    add_breadcrumb @idea.name, idea_sections_path(@idea)
    add_breadcrumb "Members", nil
  end
end
