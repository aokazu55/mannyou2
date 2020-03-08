class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 200 }, uniqueness: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
  validates :password_digest, presence: true, length: { minimum: 7 }

  before_validation { email.downcase! }
  before_destroy :do_not_destroy_last_one_admin

  has_secure_password

  validates :password, presence: true, length: { minimum: 7 }
  has_many :tasks, dependent: :destroy

end
