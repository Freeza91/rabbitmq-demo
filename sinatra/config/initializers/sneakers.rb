opts = {
  amqp: "amqp://guest:guest@message:5672",
  vhost: "/"
}

Sneakers.configure(opts)
Sneakers.logger.level = Logger::INFO