class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 4 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 7 }

  has_many :tasks, dependent: :destroy

end
