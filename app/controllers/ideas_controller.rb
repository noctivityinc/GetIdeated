class IdeasController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_for_invitations
  before_filter :get_idea, :except => [:index, :new, :create] 

  def index
    @ideas = current_user.ideas.all
    if @ideas.empty?
      redirect_to new_idea_path
    end
  end

  def show
  end

  def new
    @idea = current_user.ideas.new
  end

  def create
    @idea = current_user.own_ideas.new(params[:idea])
    if @idea.save
      redirect_to idea_sections_path(@idea, :wizard => true), :notice => "#{@idea.name} Idea Created."
    else
      render :action => 'new'
    end
  end

  def edit
    set_breadcrumbs
  end

  def update
    if @idea.update_attributes(params[:idea])
      redirect_to idea_sections_path(@idea), :notice => "#{@idea.name} Idea Updated."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @idea.destroy
    redirect_to ideas_url, :notice => "Successfully destroyed the idea for #{@idea.name}.  So sad.  What's next?"
  end

  private

  def check_for_invitations
    if session[:invite_id]
      @invite = Invite.find_by_id(session[:invite_id])
      if @invite
        @invite.idea.members.create({:user_id => current_user.id, :can_edit => @invite.can_edit})
        InviteMailer.accepted(@invite, current_user).deliver
        @invite.destroy
        flash[:notice] = "You are now a member of the #{@invite.idea.name} idea.  The one page ideation plan is below."
        redirect_to idea_sections_path(@invite.idea)
      end
    end
  end

  def get_idea
    @idea = current_user.ideas.find_by_id(params[:id])
    redirect_to ideas_path, :flash =>  {:error => "Could not find that idea"} unless @idea
  end

  def set_breadcrumbs
    add_breadcrumb "Ideas", ideas_path
    add_breadcrumb @idea.name, idea_sections_path(@idea)
  end

end
