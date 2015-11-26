class Publish

  AMQP_URL = {
    host: 'message',
    username: 'guest',
    password: 'guest'
  }

  class << self

    def publish(exchange, messgae)
      @x ||= channel.default_exchange
      @x.publish(messgae, persistent: true, routing_key: 'logs')
    end

    def channel
      @channel ||= connect.create_channel
    end

    def connect
      @connect ||= Bunny.new(AMQP_URL).tap do |c|
        c.start
      end
    end

  end

end