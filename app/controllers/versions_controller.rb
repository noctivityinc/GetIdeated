class VersionsController < ApplicationController
  before_filter :get_section, :set_breadcrumbs

  def index
    @versions = @section.versions.all
    # @versions.shift       # => remove the first one since that's the current version

    respond_to do |wants|
      wants.html {
        render @versions if request.xhr?
      }
      wants.js  { render :json => @versions }
    end
  end

  def revert
    @section.update_attribute(:content, @version.content)
    flash[:notice] = "Version reverted successfully"
    redirect_to section_versions_path(@section)
  end

  private

  def get_section
    if params[:section_id] 
      @section = Section.find_by_id(params[:section_id])
    elsif params[:id]
      @version = Version.find_by_id(params[:id])
      @section = @version.section if @version
    end

    @sections = @section.idea.sections.all
    redirect_to root_url, :notice => "Section could not be found" unless @section
  end

  def set_breadcrumbs
    add_breadcrumb "Ideas", ideas_path
    add_breadcrumb @section.idea.name, idea_sections_path(@section.idea)
    add_breadcrumb @section.name, section_path(@section)
    add_breadcrumb "Versions", ''
  end
end