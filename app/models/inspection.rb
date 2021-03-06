class Inspection < ApplicationRecord
  include Rails.application.routes.url_helpers

  MAX_COUNT = 30

  attr_accessor :restaurant_camis

  self.inheritance_column = 'sti_type'

  belongs_to :restaurant
  has_many :violations

  validates :restaurant_id, presence: true
  validates :inspected_at, uniqueness: { scope: :restaurant_id }

  def url
    api_v1_restaurant_inspection_url(restaurant, self)
  end

  def restaurant_url
    api_v1_restaurant_url(restaurant)
  end

  def violations_url
    api_v1_restaurant_inspection_violations_url(restaurant, self)
  end

  def as_json(options = {})
    {
      id: id,
      type: type,
      score: score,
      grade: grade,
      inspected_at: inspected_at,
      graded_at: graded_at,
      url: url,
      restaurant_url: restaurant_url,
      violations_url: violations_url,
    }
  end
end
