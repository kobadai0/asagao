class Vote < ApplicationRecord
  belongs_to :entry
  belongs_to :member

  validate do
    unless member && member.votable_for?(entry)
      errors.add(:base, :invalid) # モデルオブジェクト全体にエラーを加える
    end
  end
end
