class Question < ApplicationRecord
  mount_uploader :image, AssetUploader

	enum question_type: {'Short Question' => 0, 'Image Question' => 1, 'Blank Statement' => 2}
	belongs_to :course
end
