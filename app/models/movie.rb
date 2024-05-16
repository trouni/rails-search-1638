class Movie < ApplicationRecord
  belongs_to :director

  include PgSearch::Model
  pg_search_scope :search,
    against: [:title, :synopsis],
    associated_against: {
      director: [:first_name, :last_name]
    },
    using: {
      tsearch: { prefix: true }
    }

  # pg_search_scope :search_only_on_title

  multisearchable against: [:title, :synopsis]
end
