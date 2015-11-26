class ProcessorWorker

  include Sneakers::Worker
  from_queue :logs

  def work(msg)
    p "process msg"
    Log.show(msg)
    ack!
  end

end