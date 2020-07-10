class MembersController < ApplicationController

  #GET /members
  def index
    @members = Member.all
    render json: @members, include: {website: {only: :short_url}},
                           except: [:created_at, :updated_at]
  end

  #GET /members/member_id
  def show
    @member = Member.includes(:website).find(params[:id])
    render json: @member, include: {website: {only: [:url, :short_url, :headings]},
                          friends: {only: [:first_name, :last_name, :profile_path]}},
                          except: [:created_at, :updated_at, :profile_path]
  end

  #POST /members
  def create
    @member = Member.new(member_params)
    @member.website.populate_website_data

    if @member.save
      render json: @member, status: :created, location: @member
    else
      render json: @member.errors, status: :unprocessable_entity
    end
  end

  #GET experts
  #returns array of records of members for a specified heading
  #that are not already friends with the member from which the search originated


  def search_experts
    @member = Member.find(params[:member_id])
    @member_friend_ids = @member.friends.pluck(:id)
    @member_friend_ids << params[:member_id]
    @expert_members_ids = Website.where.not(member_id: @member_friend_ids)
                          .select { |website| website.headings.include?(params[:search_heading])}
                          .pluck(:member_id)
    @experts = Member.includes(:friends).where(friendships: {member_id: @expert_members_ids}).
                      where.not(id: @member.id)
    render json: experts_with_connections(@member, @experts)
  end

  private

  def member_params
    params.require(:member).permit(:first_name, :last_name, website_attributes: [:url])
  end

  def experts_with_connections(member, experts)
    @experts_with_connections = experts.map do |post|
      { id: post.id,
        first_name: post.first_name,
        last_name: post.last_name,
        profile_path: post.profile_path,
        mutual_connection: (post.friends & member.friends).first
       }
     end
  end
end
