class IdeasController < ApplicationController
  before_filter :authenticate_user!

  def index
    @ideas = current_user.ideas.all
  end

  def show
    @idea = current_user.ideas.find(params[:id])
  end

  def new
    @idea = current_user.ideas.new
  end

  def create
    @idea = current_user.ideas.new(params[:idea])
    if @idea.save
      redirect_to idea_sections_path(@idea), :notice => "#{@idea.name} Idea Created."
    else
      render :action => 'new'
    end
  end

  def edit
    @idea = current_user.ideas.find(params[:id])
    set_breadcrumbs
  end

  def update
    @idea = current_user.ideas.find(params[:id])
    if @idea.update_attributes(params[:idea])
      redirect_to idea_sections_path(@idea), :notice => "#{@idea.name} Idea Updated."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @idea = current_user.ideas.find(params[:id])
    @idea.destroy
    redirect_to ideas_url, :notice => "Successfully destroyed idea."
  end

  def set_breadcrumbs
    add_breadcrumb "Ideas", ideas_path
    add_breadcrumb @idea.name, idea_sections_path(@idea)
  end

end
