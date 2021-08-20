class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_one :cart
    email_valid = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

    validates :email, presence: true, format: { with: email_valid }, uniqueness: {case_sensitive: false}
    validates :name, presence: true
    validates :username, length: {in: 2..32}
    validates :pass, presence: true, length: {minimum: 6, maximum: 8}
end
