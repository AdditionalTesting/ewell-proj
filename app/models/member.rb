class Member < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_one :website, autosave: true
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  after_create :path_to_profile

  accepts_nested_attributes_for :website, reject_if: :valid_url?

  validates :first_name, :last_name, presence: true

  private

  def path_to_profile
    self.profile_path = url_for(controller: 'members', action: 'show', id: self.id)
    self.save
  end

  def valid_url?(attributes)
    uri = URI.parse(attributes[:url])
    !uri.is_a?(URI::HTTP) || !uri.host.present?
  rescue URI::InvalidURIError
    true
  end
end
