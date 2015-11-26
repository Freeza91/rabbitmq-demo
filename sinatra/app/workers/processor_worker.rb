class ProcessorWorker

  include Sneakers::Worker
  from_queue :logs

  def work(msg)
    Log.show(msg)
    ack!
  end

end