class Photograph < ApplicationRecord
  belongs_to :activity
  belongs_to :user
  has_many :photos
  has_attached_file :photo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/pic_160.png"
  validates_attachment :photo, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  accepts_nested_attributes_for :photos, allow_destroy: true

  validates :name, :intro, :manifesto, :photos, presence: true

  self.per_page = 2
  def cover_url(psize=:thumb)
    return photos.first.photo.url(psize)
    photo ? photo.url(psize) : photos.first.photo.url(psize)
  end

  def vote
    self.vote_numbers = self.vote_numbers.to_i+1
    self.save!
  end
end
