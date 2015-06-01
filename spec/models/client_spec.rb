require 'rails_helper'

RSpec.describe Client, type: :model do

	context 'validations' do
		subject { build(:client) }
		it { should validate_presence_of(:name) }
		it { should validate_presence_of(:slug) }
		it { should validate_length_of(:name).is_at_least(4) }
		it { should validate_length_of(:slug).is_at_least(4) }
		it 'should ensure phone has a length of 10' do
			if !subject.phone == nil
				expect(subject.length).to eq 10
			end
		end
		it { should validate_uniqueness_of(:slug) }
	end

	context 'with valid attributes' do
		let!(:client) { create(:client) }

		it 'should have set slug to to_param' do
			expect(client.to_param).to eq client.slug
		end
		it 'should parameterize slug' do
			parameterized = create(:client, slug: "a b c")
			expect(parameterized.slug).to eq "a-b-c"
		end
		it 'should return area_code' do
			expect(client.area_code).to eq client.phone.first(3)
		end
		it 'should return phone_prefix' do
			expect(client.phone_prefix).to eq client.phone.slice(3,3)
		end
		it 'should return phone_suffix' do
			expect(client.phone_suffix).to eq client.phone.last(4)
		end
		it 'should find by first letter' do
			letter = client.name.first(1)
			clients = Client.find_by_first_letter(letter)
			expect(clients).to include client
		end
	end


end
