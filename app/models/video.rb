class Video < ApplicationRecord
    acts_as_votable

    has_one_attached :clip
    has_one_attached :thumbnail
    
    validates :title, presence: true, length: {maximum: 40}
    validates :clip, presence: true, blob: { content_type: :video }
    validates :thumbnail, blob: { content_type: :image }

    belongs_to :user
    has_many :histories, dependent: :destroy
    has_many :comments, dependent: :destroy

    def self.search(query)
        if query
            where(["LOWER(title) LIKE LOWER(?)", "%#{query}%"])
        else
            all
        end
    end
end
