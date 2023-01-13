class Question < ApplicationRecord
  belongs_to :user

  has_many :answers, -> { order(best: :desc) }, dependent: :destroy

  has_many_attached :files

  validates :body, :title, presence: true
end
