class SectionsController < ApplicationController
  before_filter :get_idea, :only => [:index, :create]

  def index
    @sections = @idea.sections.all
    @comments = @idea.comments.all
    @comment = @idea.comments.new
    add_idea_crumbs(@idea)
  end

  def show
    @section = Section.find(params[:id])
    @comments = @section.comments.all
    @comment = @section.comments.new
    set_breadcrumbs
  end

  def new
    @section = @idea.sections.new
  end

  def create
    @section = @idea.sections.new(params[:section])
    if @section.save
      redirect_to @section, :notice => "Successfully created section."
    else
      render :action => 'new'
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    @section.user = current_user
    if @section.update_attributes(params[:section])
      flash[:notice] = "#{@section.name} successfully updated" 
    else
      flash[:error] = "#{@section.name} failed to update" 
    end

    respond_to do |wants|
      wants.html {
        render @section if request.xhr?
      }
      wants.js  { render @section }
    end
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    redirect_to sections_url, :notice => "Successfully destroyed section."
  end

  private

  def get_idea
    @idea = Idea.find_by_id(params[:idea_id])
    redirect_to root_url, :notice => "Idea could not be found" unless @idea
  end

  def add_idea_crumbs(idea)
    add_breadcrumb "Ideas", ideas_path
    add_breadcrumb idea.name, idea_sections_path(idea)
  end

  def set_breadcrumbs
    add_idea_crumbs(@section.idea)
    add_breadcrumb @section.name, section_path(@section)
  end
end
