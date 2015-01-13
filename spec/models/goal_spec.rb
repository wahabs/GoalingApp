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

require 'rails_helper'

RSpec.describe Goal, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
