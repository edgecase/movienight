require File.dirname(__FILE__) + '/../spec_controller_helper'

describe LocationsController do
  describe "#create" do
    it_should_behave_like "an action that requires login"
    before do
      @location = Factory(:location)
      Location.stub!(:new).and_return(@location)
    end
    def http_request
      post :create, :location => {:some => :params}
    end
    
    describe "with valid params" do
      it "should render the list of locations" do
        http_request
        assigns[:location].should == @location
        response.should render_template("index")
      end
    end

    describe "with invalid params" do
      it "should render the list of locations" do
        @location.stub!(:save).and_return(false)
        http_request
        response.should_not be_success
      end
    end
  end
end
