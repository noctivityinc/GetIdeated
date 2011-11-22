class MembersController < ApplicationController
  before_filter :get_idea, :set_breadcrumbs, :except => [:destroy, :list] 

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
    @member.destroy

    respond_to do |wants|
      wants.html {
        render :partial => 'list', :locals => {:idea => @member.idea}  if request.xhr?
      }
    end
  end

  private

  def get_idea
    @idea = Idea.find_by_id(params[:idea_id])
    redirect_to root_url, :notice => "Idea could not be found" unless @idea
  end

  def set_breadcrumbs
    add_breadcrumb "Ideas", ideas_path
    add_breadcrumb @idea.name, idea_sections_path(@idea)
    add_breadcrumb "Members", nil
  end
end
