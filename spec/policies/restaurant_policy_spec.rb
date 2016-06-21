require 'rails_helper'

describe RestaurantPolicy do
  subject { RestaurantPolicy.new(user, restaurant) }

  let(:restaurant) { Restaurant.create }

  #add_here

end
