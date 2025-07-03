class Tag < ApplicationRecord
  has_and_belongs_to_many :memos

  validates :name, presence: true, uniqueness: { case_sensitive: false }

  scope :ordered, -> { order(:name) }
end
