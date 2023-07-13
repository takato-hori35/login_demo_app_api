require "validator/email_validator"

class User < ApplicationRecord
  before_validation :downcase_email

  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/

  has_secure_password

  validates :name, presence: true,
                   length: { maximum: 30, allow_blank: true }
  validates :email, presence: true,
                    email: { allow_blank: true }
  validates :password, presence: true,
                       length: { minimum: 8, allow_blank: true },
                       format: { with: VALID_PASSWORD_REGEX, allow_blank: true, message: :invalid_password },
                       allow_nil: true
  validates :activated, inclusion: { in: [ true, false ] } # defaultはfalseだが、念の為入れておく

  class << self
    # emailからアクティブなユーザーを返す
    def find_by_activated(email)
      find_by(email: email, activated: true)
    end
  end
  # class method end #########################

  # 自分以外の同じemailのアクティブなユーザーがいる場合にtrueを返す
  def email_activated?
    users = User.where.not(id: id)
    users.find_by_activated(email).present?
  end

  private

  # email小文字化
  def downcase_email
    self.email.downcase! if email
  end
end
