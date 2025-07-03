class Memo < ApplicationRecord
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :content, presence: true

  scope :search_by_keyword, ->(query) {
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%") if query.present?
  }

  scope :tagged_with, ->(tag_name) {
    joins(:tags).where(tags: { name: tag_name.downcase.strip })
  }

  def tag_list
    tags.pluck(:name).join(", ")
  end
end
