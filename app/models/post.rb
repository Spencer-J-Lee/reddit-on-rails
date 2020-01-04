class Post < ApplicationRecord
  validates :title, :author, :subs, presence: true

  belongs_to :author,
    foreign_key: :author_id,
    class_name:  :User

  has_many :post_subs, dependent: :destroy
  has_many :subs, through: :post_subs, inverse_of: :posts
  has_many :comments, dependent: :destroy

  def comments_by_parent_id
    comments_hash = Hash.new { |h, k| h[k] = [] }
    self.comments.includes(:author).each { |cmt| comments_hash[cmt.parent_comment_id] << cmt }
    comments_hash
  end
end
