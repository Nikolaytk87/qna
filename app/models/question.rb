class Question < ApplicationRecord
  belongs_to :user

  has_many :answers, -> { order(best: :desc) }, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable

  has_one :reward, dependent: :destroy

  has_many_attached :files

  accepts_nested_attributes_for :links, reject_if: :all_blank, allow_destroy: true
  accepts_nested_attributes_for :reward, reject_if: :all_blank, allow_destroy: true

  validates :body, :title, presence: true
end
