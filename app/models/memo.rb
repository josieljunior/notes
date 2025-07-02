class Memo < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  scope :search_by_keyword, ->(query) {
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%") if query.present?
  }
end
