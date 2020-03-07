class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  scope :sort_deadline_asc, -> {order(deadline: :asc)}
  scope :sort_priority_desc, -> {order(priority: :desc)}
  scope :title_search, -> (title){ where("title LIKE ?", "%#{title}%") }
  scope :status_search, -> (status) { where(status: status)}

end
