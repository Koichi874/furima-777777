class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  validates :nickname, presence: true

  PASSWORD_REGEX = /\A(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true,
                       format: { with: PASSWORD_REGEX, message: '英字と数字の両方を含めてください' }

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: '全角(漢字・ひらがな・カタカナ)を使用してください' } do
    validates :first_name
    validates :last_name
  end

  with_options presence: true, format: { with: /\A[ぁ-んァ-ヶ一-龥々]+\z/, message: '全角カタカナを使用してください' } do
    validates :first_name_kana, presence: true
    validates :last_name_kana, presence: true
  end

  validates :birthday, presence: true
end
