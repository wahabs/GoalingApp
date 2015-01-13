# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  subject_id   :integer          not null
#  subject_type :string           not null
#  body         :text             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.paragraph(2, true, 4) }
  end
end
