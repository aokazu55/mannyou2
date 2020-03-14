class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 200 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  validates :password_digest, presence: true, length: { minimum: 7 }
  has_secure_password

  before_validation { email.downcase! }
  before_destroy :do_not_destroy_last_one_admin

  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy

  private

  def do_not_destroy_last_one_admin
    if self.admin? && User.where(admin: :true).count == 1
      throw :abort
    end
  end
end
