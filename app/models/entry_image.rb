class EntryImage < ApplicationRecord
  belongs_to :entry
  has_one_attached :data #activestorageの利用
  acts_as_list scope: :entry

  attribute :new_data #属性の設定

  validates :new_data, presence: { on: :create } #モデルを新規作成する場合のみバリデートする

  validate if: :new_data do #do-endで囲むバリエーション
    if new_data.respond_to?(:content_type)
      unless new_data.content_type.in?(ALLOWED_CONTENT_TYPES)
        errors.add(:new_data, :invalid_iamge_type)
      end
    else
      errors.add(:new_data, :invalid)
    end    
  end

  before_save do
    self.data = new_data if new_data
  end
end
