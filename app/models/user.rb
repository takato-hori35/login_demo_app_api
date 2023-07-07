class User < ApplicationRecord
  VALID_PASSWORD_REGEX = /\A[\w\-]+\z/

  has_secure_password

  validates :name, presence: true,
                   length: { maximum: 30, allow_blank: true }
  validates :password, presence: true,
                       length: { minimum: 8, allow_blank: true },
                       format: { with: VALID_PASSWORD_REGEX, allow_blank: true, message: :invalid_password },
                       allow_nil: true
  validates :activated, inclusion: { in: [ true, false ] } # defaultはfalseだが、念の為入れておく
end
