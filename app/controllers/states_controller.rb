class StatesController < ApplicationController
  def index
    @states = State.all
  end

  def show
    @state = State.find(params[:id])
  end

  def new
    @state = State.new
  end

  def create
    @state = State.new(params[:state])
    if @state.save
      redirect_to @state, :notice => "Successfully created state."
    else
      render :action => 'new'
    end
  end

  def edit
    @state = State.find(params[:id])
  end

  def update
    @state = State.find(params[:id])
    if @state.update_attributes(params[:state])
      redirect_to @state, :notice  => "Successfully updated state."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @state = State.find(params[:id])
    @state.destroy
    redirect_to states_url, :notice => "Successfully destroyed state."
  end
end
