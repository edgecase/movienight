class NightsController < ApplicationController
  before_filter :persist_host_info, :only => [:send_invitations]

  def index
    @nights = Night.all

    respond_to do |format|
      format.html
      format.xml  { render :xml => @nights }
    end
  end

  def show
    @night = Night.find(params[:id])

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @night }
    end
  end

  def new
    @night = Night.new

    respond_to do |format|
      format.html 
      format.xml  { render :xml => @night }
    end
  end

  def edit
    @night = Night.find(params[:id])
  end

  def create
    @night = Night.new(params[:night])
    @night.host = current_user

    respond_to do |format|
      if @night.save
        flash[:success] = 'Night was successfully created.'
        format.html { redirect_to(@night) }
        format.xml  { render :xml => @night, :status => :created, :location => @night }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @night.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @night = Night.find(params[:id])

    respond_to do |format|
      if @night.update_attributes(params[:night])
        flash[:notice] = 'Night was successfully updated.'
        format.html { redirect_to(@night) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @night.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @night = Night.find(params[:id])
    @night.destroy

    respond_to do |format|
      format.html { redirect_to(nights_url) }
      format.xml  { head :ok }
    end
  end

  def add_invitations
    @night = Night.find(params[:id])
  end

  def send_invitations
    @night = Night.find(params[:id])
    @night.update_attributes(params[:night])
    flash[:success] = "Invitations sent."
    redirect_to @night
  end

  def nonmember_rsvp
    
  end
end
