require 'resque'

class ResqueStatus
  
  @queued = {}
  @wip = {}

  def self.redis=(server)
    Resque.redis = server
  end

  def self.queued
    queues = Resque.queues()
    queues.each do |q|
      @queued[q] = Resque.size(q)
    end
    @queued
  end

  def self.wip
    queues = Resque.queues()
    working = Resque.working()

    queues.each do |q|
      @wip[q] = 0
    end

    working.each do |worker|
      queue = worker.job['queue']
      @wip[queue] += 1
    end
    @wip
  end    

  def self.to_collectd(hostname)
    output = []

    @queued = self.queued
    @wip = self.wip
    @queued.each do |key, value|
      output << "PUTVAL #{hostname}/#{key}/queue_length N:#{value}"
    end
    @wip.each do |key, value|
      output << "PUTVAL #{hostname}/#{key}/current N:#{value}"
    end
    output
  end

end