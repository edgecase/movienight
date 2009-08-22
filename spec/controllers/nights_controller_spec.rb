require File.expand_path(File.dirname(__FILE__) + '/../spec_controller_helper')

describe NightsController do

  def mock_night(stubs={})
    @mock_night ||= mock_model(Night, stubs)
  end
  
  describe "GET index" do
    it_should_behave_like "an action that requires login"

    def http_request
      get :index
    end

    it "assigns all nights as @nights" do
      Night.stub!(:find).with(:all).and_return([mock_night])
      http_request
      assigns[:nights].should == [mock_night]
    end
  end

  describe "GET show" do
    it_should_behave_like "an action that requires login"

    def http_request
      get :show, :id => "37"
    end

    it "assigns the requested night as @night" do
      Night.stub!(:find).with("37").and_return(mock_night)
      http_request
      assigns[:night].should equal(mock_night)
    end
  end

  describe "GET new" do
    it_should_behave_like "an action that requires login"

    def http_request
      get :new
    end

    it "assigns a new night as @night" do
      Night.stub!(:new).and_return(mock_night)
      http_request
      assigns[:night].should equal(mock_night)
    end
  end

  describe "GET edit" do
    it_should_behave_like "an action that requires login"

    def http_request
      get :edit, :id => "37"
    end

    it "assigns the requested night as @night" do
      Night.stub!(:find).with("37").and_return(mock_night)
      http_request
      assigns[:night].should equal(mock_night)
    end
  end

  describe "POST create" do
    it_should_behave_like "an action that requires login"

    def http_request
      post :create, :night => {}
    end

    describe "with valid params" do
      it "assigns a newly created night as @night" do
        Night.stub!(:new).with({'these' => 'params'}).and_return(mock_night(:save => true))
        post :create, :night => {:these => 'params'}
        assigns[:night].should equal(mock_night)
      end

      it "redirects to the created night" do
        Night.stub!(:new).and_return(mock_night(:save => true))
        post :create, :night => {}
        response.should redirect_to(night_url(mock_night))
      end
    end
    
    describe "with invalid params" do
      it "assigns a newly created but unsaved night as @night" do
        Night.stub!(:new).with({'these' => 'params'}).and_return(mock_night(:save => false))
        post :create, :night => {:these => 'params'}
        assigns[:night].should equal(mock_night)
      end

      it "re-renders the 'new' template" do
        Night.stub!(:new).and_return(mock_night(:save => false))
        post :create, :night => {}
        response.should render_template('new')
      end
    end
    
  end

  describe "PUT update" do
    
    it_should_behave_like "an action that requires login"

    def http_request
      put :update, :id => 1, :night => {}
    end

    describe "with valid params" do
      it "updates the requested night" do
        Night.should_receive(:find).with("37").and_return(mock_night)
        mock_night.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :night => {:these => 'params'}
      end

      it "assigns the requested night as @night" do
        Night.stub!(:find).and_return(mock_night(:update_attributes => true))
        put :update, :id => "1"
        assigns[:night].should equal(mock_night)
      end

      it "redirects to the night" do
        Night.stub!(:find).and_return(mock_night(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(night_url(mock_night))
      end
    end
    
    describe "with invalid params" do
      it "updates the requested night" do
        Night.should_receive(:find).with("37").and_return(mock_night)
        mock_night.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :night => {:these => 'params'}
      end

      it "assigns the night as @night" do
        Night.stub!(:find).and_return(mock_night(:update_attributes => false))
        put :update, :id => "1"
        assigns[:night].should equal(mock_night)
      end

      it "re-renders the 'edit' template" do
        Night.stub!(:find).and_return(mock_night(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end
    
  end

  describe "DELETE destroy" do
    it_should_behave_like "an action that requires login"

    def http_request
      delete :destroy, :id => "37"
    end

    it "destroys the requested night" do
      Night.should_receive(:find).with("37").and_return(mock_night)
      mock_night.should_receive(:destroy)
      delete :destroy, :id => "37"
    end
  
    it "redirects to the nights list" do
      Night.stub!(:find).and_return(mock_night(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(nights_url)
    end
  end

end
