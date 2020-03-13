class Task < ApplicationRecord
  # include SearchModule

  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :priority, presence: true
  validates :status, presence: true

  belongs_to :user, foreign_key: "user_id"

  scope :sort_deadline_asc, -> {order(deadline: :asc)}
  scope :sort_priority_desc, -> {order(priority: :desc)}
  scope :title_search, -> (title){ where("title LIKE ?", "%#{title}%") }
  scope :status_search, -> (status) { where(status: status)}
  scope :currentuser_task, -> (current_user_id){ where(user_id: current_user_id) }

  has_many :task_labels, dependent: :destroy, foreign_key: 'task_id'
  has_many :labels, through: :task_labels, source: :label

  accepts_nested_attributes_for :task_labels

end
