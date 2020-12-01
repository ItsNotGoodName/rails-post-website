module Voteable
  extend ActiveSupport::Concern

  included do
    scope :with_vote_value, ->(user) {
      plural_name = name.downcase.pluralize
      select("#{plural_name}.*, votes.value as vote_value")
        .joins("LEFT JOIN votes ON votes.user_id = #{user.nil? && -1 || user.id} AND votes.voteable_id = #{plural_name}.id AND votes.voteable_type = '#{name}' ")
    }
  end
end
