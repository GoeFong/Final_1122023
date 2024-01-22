# == Schema Information
#
# Table name: donvis
#
#  id         :bigint           not null, primary key
#  city       :string
#  country    :string
#  email      :string
#  sdt        :string
#  state      :string
#  status     :string
#  ten        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Donvi < ApplicationRecord
    resourcify
    
    validates :country, presence: true
    validates :state, inclusion: { in: ->(record) { record.states.keys }, allow_blank: true }
    validates :state, presence: { if: ->(record) { record.states.present? } }
    validates :city, inclusion: { in: ->(record) { record.cities }, allow_blank: true }
    validates :city, presence: { if: ->(record) { record.cities.present? } }
    validates :ten, presence: true


    has_many :donvi_users, dependent: :destroy
    has_many :users, through: :donvi_users
    has_many :vanbans, dependent: :nullify


    TRANGTHAI_DONVI = [
        { label: "Đang hoạt động", gia_tri: "dang_hoat_dong" },
        { label: "Ngưng hoạt động", gia_tri: "ngung_hoat_dong" }
    ].freeze

    def countries
        CS.countries.with_indifferent_access
    end

    def states
        CS.states(country).with_indifferent_access
    end

    def cities
        CS.cities(state, country) || []
    end

    def country_label
        countries[country]
    end

    def state_label
        states[state]
    end
end
