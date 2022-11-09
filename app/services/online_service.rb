class OnlineService
  def initialize(user:, room:, presence:)
    @user = user
    @room = room
    @presence = presence
  end

  def perform
    set_online.update(online: @presence)
    broadcast_online
  end

  def broadcast_online
    ActionCable.server.broadcast "online_channel_#{@room.id}",
                                 online: render_online, nickname: @user.nickname
  end

  def render_online
    ApplicationController.renderer.render(partial: 'onlines/online', locals: {
                                            online: @online
                                          })
  end

  def set_online
    @online = @room.onlines.find_or_create_by(user: @user)
  end
end
