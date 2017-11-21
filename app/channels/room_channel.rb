class RoomChannel < ApplicationCable::Channel
  include UsersHelper

  def subscribed
    stream_from "room_channel"
    stream_from "room_channel_user_#{message_user.id}"
    set_online(message_user)
    ActionCable.server.broadcast 'room_channel',
                                   online_user: { 
                                      is_online: true,
                                      username: message_user.username
                                    }
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    set_offline(message_user)
    ActionCable.server.broadcast 'room_channel',
                                   online_user: { 
                                      is_online: false,
                                      username: message_user.username
                                    }
  end
end
