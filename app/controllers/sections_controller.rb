class SectionsController < ApplicationController
  before_filter :get_idea, :only => [:index, :new, :create]

  def index
    @sections = @idea.sections.all
    @comments = @idea.comments.all
    @comment = @idea.comments.new
    add_idea_crumbs(@idea)
  end

  def show
    @section = Section.find(params[:id])
    @sections = @section.idea.sections.all    
    @comments = @section.comments.all
    @comment = @section.comments.new
    set_breadcrumbs
  end

  def new
    @sections = @idea.sections.all
    @section = @idea.sections.new
  end

  def create
    @section = @idea.sections.new(params[:section])
    @section.custom = true
    if authenticate_access(@section.idea)
      if @section.save
        redirect_to @section, :notice => "Successfully created #{@section.name} section."
      else
        @sections = @idea.sections.all
        render :action => 'new'
      end
    end
  end

  def edit
    @section = Section.find_by_id(params[:id])
    if authenticate_access(@section.idea)
      @sections = @section.idea.sections.all
    end
  end

  def update
    @section = Section.find(params[:id])
    if authenticate_access(@section.idea)
      @section.user = current_user
      respond_to do |wants|
        if @section.update_attributes(params[:section]) 
          # needed for left nav
          @sections = @section.idea.sections.all   
          wants.html {
            if request.xhr?
              render :json => {:section => render_to_string(@section), :left_nav => render_to_string(:partial => 'layouts/left_nav')} if request.xhr?
            else
              redirect_to @section, :notice => "Successfully updated #{@section.name} section." 
            end 
          }
          wants.js  { render @section }
        else
          render :edit
        end
      end
    end
  end

  def destroy
    @section = Section.find_by_id(params[:id])
    if current_user.owns?(@section.idea)
      @section.destroy
      redirect_to idea_sections_path(@section.idea), :notice => "Successfully destroyed #{@section.name} section."
    end
  end

  private

  def get_idea
    @idea = Idea.find_by_id(params[:idea_id])
    redirect_to root_url, :notice => "Idea could not be found" unless @idea
  end

  def authenticate_access!
    authenticate_access(@idea)
  end

  def authenticate_access(idea)
    if idea && current_user.authorized_to_edit?(idea)
      return true
    else
      flash[:error] = 'You are not authorized to edit the plan for this idea'
     return redirect_to ideas_path
    end 
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
