require 'rails_helper'

RSpec.describe Restaurant, :type => :model do
	let(:restaurant) { FactoryGirl.build(:restaurant) }

	context 'validations' do
		#addhere
    it { expect(restaurant).to validate_presence_of(:location) }
    it { expect(restaurant).to validate_uniqueness_of(:name) }
    it { expect(restaurant).to validate_presence_of(:name) }
	end
end
