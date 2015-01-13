# == Schema Information
#
# Table name: goals
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  body       :text
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  is_private :boolean
#  completed  :boolean
#

FactoryGirl.define do
  factory :goal do
    title { Faker::Lorem.sentence(3, true, 4) }
    body { Faker::Lorem.paragraph(2, true, 4) }
    is_private false
  end

end
