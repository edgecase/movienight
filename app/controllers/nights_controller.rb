class NightsController < ApplicationController
  # GET /nights
  # GET /nights.xml
  def index
    @nights = Night.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @nights }
    end
  end

  # GET /nights/1
  # GET /nights/1.xml
  def show
    @night = Night.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @night }
    end
  end

  # GET /nights/new
  # GET /nights/new.xml
  def new
    @night = Night.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @night }
    end
  end

  # GET /nights/1/edit
  def edit
    @night = Night.find(params[:id])
  end

  # POST /nights
  # POST /nights.xml
  def create
    @night = Night.new(params[:night])
    @night.host = current_user

    respond_to do |format|
      if @night.save
        flash[:notice] = 'Night was successfully created.'
        format.html { redirect_to(@night) }
        format.xml  { render :xml => @night, :status => :created, :location => @night }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @night.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /nights/1
  # PUT /nights/1.xml
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

  # DELETE /nights/1
  # DELETE /nights/1.xml
  def destroy
    @night = Night.find(params[:id])
    @night.destroy

    respond_to do |format|
      format.html { redirect_to(nights_url) }
      format.xml  { head :ok }
    end
  end
end
