class Friendship < ApplicationRecord
  belongs_to :member, counter_cache: :friend_count
  belongs_to :friend, class_name: 'Member'

  validates :member, uniqueness: { scope: :friend }
  validate :cannot_friend_self

  def self.create_reciprocal_for_ids(member_id, friend_id)
    member_friendship = Friendship.create(member_id: member_id, friend_id: friend_id)
    friend_friendship = Friendship.create(member_id: friend_id, friend_id: member_id)
    [member_friendship, friend_friendship]
  end

  def self.destroy_reciprocal_for_ids(member_id, friend_id)
    friendship1 = Friendship.find_by(member_id: member_id, friend_id: friend_id)
    friendship2 = Friendship.find_by(member_id: friend_id, friend_id: member_id)
    friendship1.destroy
    friendship2.destroy
  end

  private

  def cannot_friend_self
    errors.add(:member, "you can't be your own friend... sorry :(") if member_id == friend_id
  end
end
