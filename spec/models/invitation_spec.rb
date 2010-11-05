require 'spec_helper'

describe Invitation do
  it "generates an access hash before create" do
    pending
    invitation = Invitation.new(:night => Night.new)
    invitation.access_hash.should be_blank
    invitation.save!
    invitation.access_hash.should_not be_blank
  end
end
