class User < ApplicationRecord
  has_secure_password
  before_validation :downcase_email
  
  has_many :budgets, dependent: :destroy
  has_many :transactions, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :first_name, presence: true, unless: :from_oauth?
  validates :last_name, presence: true, unless: :from_oauth?
  validates :email, presence: true, uniqueness: { case_sensitive: false },
                                    format: VALID_EMAIL_REGEX,
                                    unless: :from_oauth?

  def full_name
    "#{first_name} #{last_name}".strip.squeeze(' ').titleize
  end

  def from_oauth?
    provider.present? && uid.present?
  end

  def downcase_email
    self.email.downcase! if email.present?
  end
end
