class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_one :cart

    validates :name, presence: true
    validates :username, presence: true
    validates :pass, presence: true, length: {minimum: 6, maximum: 8}
end
