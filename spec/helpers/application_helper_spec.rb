require 'spec_helper'
require 'digest/md5'

describe ApplicationHelper do
  describe "gravatar_url" do
    let(:email)  { "UserEmail@foo.com" }
    let(:digest) { Digest::MD5.hexdigest(email.downcase) }
    let(:user)   { Factory(:user, :email => email) }

    it "contains the MD5 hash of the user's downcased email" do
      url = helper.gravatar_url(user)
      url.should match(/avatar\/#{digest}/)
    end

    context "when a size is specified" do
      it "contains the size parameter" do
        url = helper.gravatar_url(user, 512)
        url.should match(/[&|?]s=512/)
      end
    end
  end
end
