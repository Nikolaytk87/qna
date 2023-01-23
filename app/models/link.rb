class Link < ApplicationRecord
  belongs_to :linkable, polymorphic: true

  validates :name, :url, presence: true
  validates :url, url: { no_local: true, schemes: %w[http https], public_suffix: true }

  def gist?
    URI.parse(url).host&.include?('gist')
  end
end
