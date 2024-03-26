class User < ApplicationRecord
  SUBSCRIPTION_TYPES = ['Free', 'Advanced', 'Pro'].freeze
  has_many :reviews, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :guests, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
