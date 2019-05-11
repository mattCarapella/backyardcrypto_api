class Picture < ApplicationRecord
  belongs_to :coin
  #belongs_to :user
  # mount_uploader :image, CoinImageUploader
  # validate :picture_size
  # validate :approve_only_one, on: :activate

  private 

    def picture_size
      if image.size > 5.megabytes
        errors.add(:picture, "Picture must be smalled than 5MB.")
      end
    end

    def approve_only_one
      accepted_pictures = Picture.where(coin_id: self.coin.id, accepted: true)
      unless accepted_pictures.count < 1 
        errors.add :base, 'There can only be one accepted answer'
      end
    end
end
