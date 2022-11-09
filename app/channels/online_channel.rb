class OnlineChannel < ApplicationCable::Channel
  def subscribed
    logger.info "Subscribed to RoomChannel, roomId: #{params[:roomId]}"
    @room = Room.find(params[:roomId])
    @presence = 'В сети'

    stream_from "online_channel_#{@room.id}"

    broadcast
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    @presence = 'Не в сети'

    broadcast
  end

  private

  def broadcast
    OnlineService.new(user: current_user, room: @room, presence: @presence).perform
  end
end
