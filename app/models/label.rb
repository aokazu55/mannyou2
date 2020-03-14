class Label < ApplicationRecord
  validates :label_type, presence: true
  has_many :task_labels, dependent: :destroy, foreign_key: 'label_id'
  has_many :tasks, through: :task_labels, source: :task

  belongs_to :user, optional: true
end
