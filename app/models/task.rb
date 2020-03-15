class StatusValidator < ActiveModel::Validator
  def validate(record)
    unless ["未着手","着手中","完了"].include?(record.status)
      record.errors[:status] << 'が不正です。'
    end
  end
end

class Task < ApplicationRecord
  # include SearchModule

  validates :title, presence: true
  validates :content, presence: true
  validates :deadline, presence: true
  validates :priority, presence: true
  
  include ActiveModel::Validations
  validates :status, presence: true
  validates_with StatusValidator

  belongs_to :user, foreign_key: "user_id"

  scope :sort_deadline_asc, -> {order(deadline: :asc)}
  scope :sort_priority_desc, -> {order(priority: :desc)}
  scope :title_search, -> (title){ where("title LIKE ?", "%#{title}%") }
  scope :status_search, -> (status) { where(status: status)}
  scope :label_search, -> (label) { where(status: status)}
  scope :search_with_label, -> (label){where(id: TaskLabel.where(label_id: label).pluck(:task_id))}

  has_many :task_labels, dependent: :destroy, foreign_key: 'task_id'
  has_many :labels, through: :task_labels, source: :label

  accepts_nested_attributes_for :task_labels

end
