# == Schema Information
#
# Table name: vanbans
#
#  id            :bigint           not null, primary key
#  level         :string
#  link_to_apply :string
#  loaivanban    :string
#  published_at  :datetime
#  slug          :string
#  status        :string           default("cho_xu_ly")
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  donvi_id      :bigint           not null
#  user_id       :bigint           not null
#
# Indexes
#
#  index_vanbans_on_donvi_id  (donvi_id)
#  index_vanbans_on_slug      (slug) UNIQUE
#  index_vanbans_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (donvi_id => donvis.id)
#  fk_rails_...  (user_id => users.id)
#
class Vanban < ApplicationRecord
  extend FriendlyId
  after_destroy_commit {broadcast_remove_to "vanbans"}
  validates :loaivanban, presence: true
  validates :title, presence: true


  friendly_id :slug_candidates, use: [:slugged, :finders]
  belongs_to :user
  belongs_to :donvi
  has_rich_text :ghichu
  has_one_attached :file_vanban
  has_many :vanban_users, dependent: :destroy
  has_many :users, through: :vanban_users
  has_many :congviecs, dependent: :nullify
  



  scope :desc, -> { order(created_at: :desc) }


  
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "donvi_id", "id", "level", "link_to_apply", "loaivanban", "published_at", "slug", "status", "title", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["congviec_users", "congviecs", "congviecs_cv", "donvi", "file_vanban_attachment", "file_vanban_blob", "rich_text_ghichu", "user", "users", "users_cv", "vanban_users"]
  end

  TT_VANBAN = [
    { label: "Chờ xử lý", gia_tri: "cho_xu_ly" },
    { label: "Đã công bố", gia_tri: "da_cong_bo" },
    { label: "Đã lưu trữ", gia_tri: "da_luu_tru" }
  ].freeze

  LOAI_VANBAN = [
    { label: "Chỉ đạo", gia_tri: "chi_dao" },
    { label: "Quyết định", gia_tri: "quyet_dinh" }
  ].freeze

  MUCDO_VANBAN = [
    "1","2","3","4"].freeze
  
  def slug_candidates
     [:loaivanban, [:loaivanban, :id]]
  end

  def cho_xu_ly?
    self.status = Vanban::TT_VANBAN[:cho_xu_ly]
  end

  def da_cong_bo?
    self.status = Vanban::TT_VANBAN[:da_cong_bo]
  end

  def da_luu_tru?
    self.status = Vanban::TT_VANBAN[:da_luu_tru]
  end

  def should_generate_new_friendly_id?
    if !slug?
      title_changed?
    else
      false
    end
  end
end
