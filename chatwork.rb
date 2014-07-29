class Chatwork

  def initialize(opts={})
    ChatWork.api_key = opts["api_key"]
    @room_id = opts["room_id"]
  end

  def message body=""
    if block_given?
      ChatWork::Message.create(room_id: @room_id, body: yield)
    else
      ChatWork::Message.create(room_id: @room_id, body: body)
    end
  end

end
