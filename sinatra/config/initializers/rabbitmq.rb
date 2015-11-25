amqp_url = {
  host: 'message',
  username: 'guest',
  password: 'guest'
}

conn ||= Bunny.new(amqp_url).tap do |c|
  c.start
end

$channel ||= conn.create_channel
$queue ||= $channel.queue('logs', durable: true)