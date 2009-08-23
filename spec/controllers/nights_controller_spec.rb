require File.expand_path(File.dirname(__FILE__) + '/../spec_controller_helper')

describe NightsController do
  
  describe "GET index" do
    it_should_behave_like "an action that requires login"

    before do
      @night = Factory.create(:night, :host => @currently_logged_in_user)
    end

    def http_request
      get :index
    end

    it "assigns all nights as @nights" do
      http_request
      assigns[:nights].should == [@night]
    end
  end

  describe "GET show" do
    it_should_behave_like "an action that requires login"

    before do
      @night = Factory.create(:night, :host => @currently_logged_in_user)
    end

    def http_request
      get :show, :id => @night.id
    end

    it "assigns the requested night as @night" do
      http_request
      assigns[:night].should == @night
    end
  end

  describe "GET new" do
    it_should_behave_like "an action that requires login"

    def http_request
      get :new
    end

    it "assigns a new night as @night" do
      http_request
      assigns[:night].should be_instance_of(Night)
      assigns[:night].should be_new_record
    end
  end

  describe "GET edit" do
    it_should_behave_like "an action that requires login"

    before do
      @night = Factory.create(:night, :host => @currently_logged_in_user)
    end

    def http_request
      get :edit, :id => @night.id
    end

    it "assigns the requested night as @night" do
      http_request
      assigns[:night].should == @night
    end
  end

  describe "POST create" do
    it_should_behave_like "an action that requires login"

    def http_request(night_attrs = {})
      post :create, :night => night_attrs
    end

    describe "with valid params" do
      before do
        http_request Factory.attributes_for(:night, :host => nil)
      end

      it "assigns a newly created night as @night" do
        assigns[:night].should be_instance_of(Night)
        assigns[:night].should_not be_new_record
      end

      it "redirects to the created night" do
        response.should redirect_to(night_url(assigns[:night]))
      end

      it "makes the current_user the host" do
        assigns[:night].host.should == @currently_logged_in_user
      end
    end
    
    describe "with invalid params" do
      before do
        http_request
      end

      it "assigns a newly created but unsaved night as @night" do
        assigns[:night].should be_instance_of(Night)
        assigns[:night].should be_new_record
      end

      it "re-renders the 'new' template" do
        response.should render_template('new')
      end
    end
    
  end

  describe "PUT update" do
    
    it_should_behave_like "an action that requires login"

    before do
      @night = Factory(:night, :host => @currently_logged_in_user)
    end

    def http_request(night_attrs = {})
      put :update, :id => @night.id, :night => night_attrs
    end

    describe "with valid params" do
      it "updates the requested night" do
        @night.bring_drinks?.should be_false
        http_request :bring_drinks => 'true'
        @night.reload.bring_drinks?.should be_true
      end

      it "assigns the requested night as @night" do
        http_request
        assigns[:night].should == @night
      end

      it "redirects to the night" do
        http_request
        response.should redirect_to(night_path(@night))
      end
    end
    
    describe "with invalid params" do
      before do
        http_request :location_id => nil
      end

      it "assigns the night as @night" do
        assigns[:night].should == @night
      end

      it "re-renders the 'edit' template" do
        response.should render_template('edit')
      end
    end
    
  end

  describe "DELETE destroy" do
    it_should_behave_like "an action that requires login"

    before do
      @night = Factory(:night, :host => @currently_logged_in_user)
    end

    def http_request
      delete :destroy, :id => @night.id
    end

    it "destroys the requested night" do
      Night.all.should include(@night)
      http_request
      Night.all.should_not include(@night)
    end
  
    it "redirects to the nights list" do
      http_request
      response.should redirect_to(nights_url)
    end
  end

  describe "GET add_invitations" do
    it_should_behave_like "an action that requires login"

    before do
      @night = Factory.create(:night, :host => @currently_logged_in_user)
    end

    def http_request
      get :add_invitations, :id => @night.id
    end

    it "finds the night" do
      http_request
      assigns[:night].should == @night
    end
  end

  describe "POST send_invitations" do
    it_should_behave_like "an action that requires login"

    before do
      @night = Factory.create(:night, :host => @currently_logged_in_user)
    end

    def http_request(emails = nil)
      post :send_invitations, :id => @night.id, :invitation_emails => emails
    end

    it "finds the night" do
      http_request
      assigns[:night].should == @night
    end

    it "sends invitations" do
      http_request "email@example.com, email2@foobar.com"
      @night.invitees.count.should == 2
    end

    it "sets flash[:success]" do
      http_request
      flash[:success].should_not be_blank
    end

    it "redirects to the night show page" do
      http_request
      response.should redirect_to(night_path(@night))
    end
  end

  describe "GET /nights/:id/nonmember_rsvp/:access_hash" do
    before do
      @night = Factory(:night)
      @night.send_invitations "foo@bar.com"
      @invitee = @night.invitees.first
    end

    def http_request(access_hash = @invitee.access_hash)
      get :nonmember_rsvp, :id => @night.id, :access_hash => access_hash
    end

    it "finds the night" do
      http_request
      assigns[:night].should == @night
    end

    it "attempts to find an invitee" do
      http_request
      assigns[:invitee].should == @invitee
      http_request "notahash"
      assigns[:invitee].should be_nil
    end
  end

  describe "PUT /nights/:id/complete_rsvp" do
    before do
      @night = Factory(:night)
      @night.send_invitations "foo@bar.com"
      @invitee = @night.invitees.first
    end

    def http_request(attending = nil)
      put :complete_rsvp, :id => @night.id, :access_hash => @invitee.access_hash, :attending => attending
    end

    it "finds the night" do
      http_request
      assigns[:night].should == @night
    end

    it "updates the invitee" do
      @invitee.attending.should be_nil
      http_request 'true'
      @invitee.reload.attending.should be_true
    end

    it "renders the complete_rsvp template" do
      http_request
      response.should redirect_to(night_url(@night))
    end
  end
end
