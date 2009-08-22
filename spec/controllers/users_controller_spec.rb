require File.dirname(__FILE__) + '/../spec_controller_helper'

describe UsersController do
  fixtures :users

  it 'allows signup' do
    lambda do
      create_user
      response.should be_redirect
    end.should change(User, :count).by(1)
  end

  it 'requires login on signup' do
    lambda do
      create_user(:login => nil)
      assigns[:user].errors.on(:login).should_not be_nil
      response.should be_success
    end.should_not change(User, :count)
  end
  
  it 'requires password on signup' do
    lambda do
      create_user(:password => nil)
      assigns[:user].errors.on(:password).should_not be_nil
      response.should be_success
    end.should_not change(User, :count)
  end
  
  it 'requires password confirmation on signup' do
    lambda do
      create_user(:password_confirmation => nil)
      assigns[:user].errors.on(:password_confirmation).should_not be_nil
      response.should be_success
    end.should_not change(User, :count)
  end

  it 'requires email on signup' do
    lambda do
      create_user(:email => nil)
      assigns[:user].errors.on(:email).should_not be_nil
      response.should be_success
    end.should_not change(User, :count)
  end
  
  
  
  def create_user(options = {})
    post :create, :user => { :login => 'quire', :email => 'quire@example.com',
      :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
  end

end

describe UsersController do

  describe "handling /users/:id/edit via GET" do
    it_should_behave_like 'an action that requires login'

    before do
      @user = Factory.create(:user)
    end

    def http_request
      get :edit, :id => @user.id
    end

    it "finds the user" do
      http_request
      assigns[:user].should == @user
    end

    it "renders the edit template" do
      http_request
      response.should render_template('edit')
    end
  end

  describe "handling /users/:id via PUT" do
    it_should_behave_like 'an action that requires login'

    before do
      @user = Factory.create(:user)
    end

    def http_request(user_attrs = {})
      put :update, :id => @user.id, :user => user_attrs
    end

    describe "with valid attributes" do
      it "updates the user" do
        http_request :name => "some new name"
        assigns[:user].name.should == "some new name"
      end

      it "sets flash[:success]" do
        http_request
        flash[:success].should_not be_blank
      end

      it "redirects to the edit page" do
        http_request
        response.should redirect_to(edit_user_path(@user))
      end
    end

    describe "with invalid attributes" do
      it "does not set flash[:success]" do
        http_request :login => ''
        flash[:success].should be_blank
      end

      it "re-renders the edit template" do
        http_request :login => ''
        response.should render_template('edit')
      end
    end
  end
  
end
