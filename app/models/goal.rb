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

class Goal < ActiveRecord::Base
  validates :title, :user, presence: true
  validate :privacy_is_a_boolean, :completed_is_a_boolean
  belongs_to :user
  after_initialize :default_to_not_completed


  private

    def privacy_is_a_boolean
      self.is_private.is_a?(TrueClass) || self.is_private.is_a?(FalseClass)
    end

    def completed_is_a_boolean
      self.completed.is_a?(TrueClass) || self.completed.is_a?(FalseClass)
    end

    def default_to_not_completed
      self.completed ||= false
    end

end
