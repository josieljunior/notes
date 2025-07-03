class Memo < ApplicationRecord
  has_and_belongs_to_many :tags

  validates :title, presence: true
  validates :content, presence: true

  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }
  scope :tagged_with, ->(tag_name) {
    joins(:tags).where(tags: { name: tag_name.downcase.strip })
  }
  scope :search_by_keyword, ->(query) {
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%") if query.present?
  }

  def archive!
    update!(archived: true)
  end

  def unarchive!
    update!(archived: false)
  end
end
