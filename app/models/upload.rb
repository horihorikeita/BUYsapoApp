class Upload < ApplicationRecord
 mount_uploader :image, ImagesUploader
 validates :title, {presence: true}
 validates :body, {presence: true}
  validates :user_id, {presence: true}

  def user
    return User.find_by(id: self.user_id)
  end
end
