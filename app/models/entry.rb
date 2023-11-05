class Entry < ApplicationRecord
  belongs_to :author, class_name: "Member", foreign_key: "member_id" #memberモデルをauthorという名前で持ってきている
  has_many :images, class_name: "EntryImage" # メソッド名を変更したいときにつけるオプション
  has_many :votes, dependent: :destroy # 参照先のレコードを削除したときに、参照元のレコードも自動削除される
  has_many :voters, through: :votes, source: :member # 関連付けているモデル名以外の名前を付けるときに使用するオプション

  STATUS_VALUES = %w(draft member_only public)

  validates :title, presence: true, length: {maximum: 200}
  validates :body, :posted_at, presence: true
  validates :status, inclusion: { in: STATUS_VALUES }

  scope :common, -> { where(status: "public") }
  scope :published, -> { where("status <> ?", "draft") }
  scope :full, -> (member) {
    where("status <> ? OR member_id = ?", "draft", member.id) }
  scope :readable_for, -> (member) { member ? full(member) : common }

  class << self
    def status_text(status)
      I18n.t("activerecord.attributes.entry.status_#{status}")
    end

    def status_options
      STATUS_VALUES.map { |status| [status_text(status), status] }
    end
  end
end