class FriendshipsController < ApplicationController

  #POST
  def create
    @friendship = Friendship.create_reciprocal_for_ids(friend_params[:member_id],
                                                      friend_params[:friend_id]).first
    if @friendship.valid?
      render json: @friendship, status: :created
    else
      render json: @friendship.errors, status: :unprocessable_entity
    end
  end

  private

  def friend_params
    params.require(:friendship).permit(:member_id, :friend_id)
  end
end
