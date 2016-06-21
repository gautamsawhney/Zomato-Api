require 'rails_helper'

describe CommentPolicy do
  subject { CommentPolicy.new(user, comment) }

  let(:comment) { Comment.create }

  #add_here
  context "being a/an mod" do
    let(:user) {  User.create('roles' => 'mod', 'email' => 'first@first.com', 'password' => 'abcdabcd') }
    # Action Specs :: Mod
    it { should permit_action(:destroy) }
    it { should permit_action(:update) }
    it { should permit_action(:show) }
    it { should permit_action(:create) }
    # Attribute Specs :: Mod
    it { should permit_mass_assignment_of(:post_id) }
    it { should permit_mass_assignment_of(:user_id) }
    it { should permit_mass_assignment_of(:title) }
  end
  context "being a/an super_admin" do
    let(:user) {  User.create('roles' => 'super_admin', 'email' => 'first@first.com', 'password' => 'abcdabcd') }
    # Action Specs :: SuperAdmin
    it { should permit_action(:destroy) }
    it { should permit_action(:update) }
    it { should permit_action(:show) }
    it { should permit_action(:create) }
    # Attribute Specs :: SuperAdmin
    it { should permit_mass_assignment_of(:post_id) }
    it { should permit_mass_assignment_of(:user_id) }
    it { should permit_mass_assignment_of(:title) }
  end
  context "being a/an restaurant_owner" do
    let(:user) {  User.create('roles' => 'restaurant_owner', 'email' => 'first@first.com', 'password' => 'abcdabcd') }
    # Action Specs :: RestaurantOwner
    it { should permit_action(:update) }
    it { should permit_action(:show) }
    it { should permit_action(:create) }
    # Attribute Specs :: RestaurantOwner
    it { should permit_mass_assignment_of(:post_id) }
    it { should permit_mass_assignment_of(:user_id) }
    it { should permit_mass_assignment_of(:title) }
  end

end
