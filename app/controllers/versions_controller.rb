class VersionsController < ApplicationController
  before_filter :get_section, :set_breadcrumbs

  def index
    @versions = @section.versions.all
    @versions.shift       # => remove the first one since that's the current version

    respond_to do |wants|
      wants.html {
        render @versions if request.xhr?
      }
      wants.js  { render :json => @versions }
    end
  end

  def show
    @version = @section.versions.find(params[:id])
  end

  def new
    @version = @section.versions.new
  end

  def create
    @version = @section.versions.new(params[:version])
    if @version.save
      redirect_to @version, :notice => "Successfully created version."
    else
      render :action => 'new'
    end
  end

  def edit
    @version = @section.versions.find(params[:id])
  end

  def update
    @version = @section.versions.find(params[:id])
    if @version.update_attributes(params[:version])
      redirect_to @version, :notice  => "Successfully updated version."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @version = @section.versions.find(params[:id])
    @version.destroy
    redirect_to versions_url, :notice => "Successfully destroyed version."
  end

  private

  def get_section
    @section = Section.find_by_id(params[:section_id])
    redirect_to root_url, :notice => "Section could not be found" unless @section
  end

  def set_breadcrumbs
    add_breadcrumb "Ideas", ideas_path
    add_breadcrumb @section.idea.name, idea_sections_path(@section.idea)
    add_breadcrumb @section.name, section_path(@section)
    add_breadcrumb "Versions", ''
  end
end
