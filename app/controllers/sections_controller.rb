class SectionsController < ApplicationController
  before_filter :get_idea, :only => [:index, :create]

  def index
    @sections = @idea.sections.all
  end

  def show
    @section = Section.find(params[:id])
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
      wants.html {  redirect_to @section }
      wants.js  { render :json => @section }
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
end
