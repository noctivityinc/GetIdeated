class VersionsController < ApplicationController
  def index
    @versions = Version.all
  end

  def show
    @version = Version.find(params[:id])
  end

  def new
    @version = Version.new
  end

  def create
    @version = Version.new(params[:version])
    if @version.save
      redirect_to @version, :notice => "Successfully created version."
    else
      render :action => 'new'
    end
  end

  def edit
    @version = Version.find(params[:id])
  end

  def update
    @version = Version.find(params[:id])
    if @version.update_attributes(params[:version])
      redirect_to @version, :notice  => "Successfully updated version."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @version = Version.find(params[:id])
    @version.destroy
    redirect_to versions_url, :notice => "Successfully destroyed version."
  end
end
