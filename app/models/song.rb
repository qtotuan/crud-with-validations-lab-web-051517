class Song < ActiveRecord::Base
  validates :title, presence: true
  validates :title, uniqueness: {
    scope: [:release_year, :artist_name],
    message: "cannot be repeated by artist in the same year"
  }

  validates :released, inclusion: { in: [true, false] }
  validates :artist_name, presence: true

  validates :release_year, presence: true, unless: Proc.new { released == false }
  validates :release_year, numericality: { less_than_or_equal_to: Date.today.year }, unless: Proc.new { released == false }
end
