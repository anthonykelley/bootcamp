# == Schema Information
#
# Table name: camps
#
#  id                     :integer          not null, primary key
#  name                   :string           not null
#  year_founded           :integer          not null
#  active                 :boolean          default(TRUE)
#  languages              :jsonb
#  full_time_tuition_cost :float            not null
#  part_time_tuition_cost :float            not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

require 'rails_helper'

RSpec.describe Camp, type: :model do
  describe 'attributes' do
    it { should respond_to(:name) }
    it { should respond_to(:year_founded) }
    it { should respond_to(:active) }
    it { should respond_to(:languages) }
    it { should respond_to(:full_time_tuition_cost) }
    it { should respond_to(:part_time_tuition_cost) }
  end

  describe 'validations' do
    context 'presence of validations' do
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:year_founded) }
      it { should validate_presence_of(:full_time_tuition_cost) }
      it { should validate_presence_of(:part_time_tuition_cost) }
    end

    context 'uniqueness validations' do
      it { should validate_uniqueness_of(:name) }
    end

    context 'inclusion of validations' do
      it do
        should validate_inclusion_of(:year_founded).
          in_array( (2000..Date.today.year).to_a )
      end
    end
  end

  describe 'class methods / scopes' do
    before(:each) do
      @camp_1 = FactoryBot.create(
        :camp, 
        name: 'NY Code Academy', 
        full_time_tuition_cost: 11000,
        part_time_tuition_cost: 7000
      )
      @camp_2 = FactoryBot.create(:camp, name: 'Iron Yard')
      @camp_3 = FactoryBot.create(
        :camp,
        name: 'DevPoint Labs', 
        full_time_tuition_cost: 20000,
        part_time_tuition_cost: 3000
      )
    end

    it 'returns camps ordered by name' do
      camps = Camp.all.by_name
      expect(camps.first).to eq(@camp_3)
      expect(camps[1]).to eq(@camp_2)
      expect(camps.last).to eq(@camp_1)
    end

    it 'returns camps ordered by full time tuition cost desc' do
      camps = Camp.all.by_full_time_tuition_cost
      expect(camps.first).to eq(@camp_3)
      expect(camps[1]).to eq(@camp_1)
      expect(camps.last).to eq(@camp_2)
    end

    it 'returns camps ordered by part time tuition cost desc' do
      camps = Camp.all.by_part_time_tuition_cost
      expect(camps.first).to eq(@camp_1)
      expect(camps[1]).to eq(@camp_2)
      expect(camps.last).to eq(@camp_3)
    end
  end
end