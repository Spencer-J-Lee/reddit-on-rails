class Sub < ApplicationRecord
  validates :title, :description, :moderator, presence: true

  belongs_to :moderator,
    foreign_key: :mod_id,
    class_name:  :User

  has_many :post_subs, dependent: :destroy
  has_many :posts, through: :post_subs, inverse_of: :subs
end
