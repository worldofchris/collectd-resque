require 'resque_status'

RSpec.describe ResqueStatus do

  it 'gets the length of the queues' do
    dummy_resque = class_double("Resque").
      as_stubbed_const(:transfer_nested_constants => true)

    expect(dummy_resque).to receive(:redis=).with("demo.server")
    expect(dummy_resque).to receive(:queues).and_return(['import', 'process', 'dispatch'])
    expect(dummy_resque).to receive(:size).with(any_args).and_return(1,2,3)

    ResqueStatus.redis ="demo.server"
    queues = ResqueStatus.queued()
    expect(queues).to eq({"import" => 1, "process"=> 2, "dispatch"=> 3})
  end

  it 'gets the amount of wip for a given queue' do
    dummy_resque = class_double("Resque").
      as_stubbed_const(:transfer_nested_constants => true)

    expect(dummy_resque).to receive(:queues).and_return(['import', 'process', 'dispatch'])
    expect(dummy_resque).to receive(:working).and_return([instance_double("Worker", :job => {"queue" => "import"}),
                                                          instance_double("Worker", :job => {"queue" => "process"}),
                                                          instance_double("Worker", :job => {"queue" => "process"})])
    queues = ResqueStatus.wip()
    expect(queues).to eq({"import" => 1,
                          "process"=> 2,
                          "dispatch"=> 0})

  end

# .job['queue']

  it 'formats the output for collectd' do
    dummy_resque = class_double("Resque").
      as_stubbed_const(:transfer_nested_constants => true)

    expect(dummy_resque).to receive(:queues).twice.and_return(['import', 'process', 'dispatch'])
    expect(dummy_resque).to receive(:size).with(any_args).and_return(1,2,3)
    expect(dummy_resque).to receive(:working).and_return([instance_double("Worker", :job => {"queue" => "import"}),
                                                          instance_double("Worker", :job => {"queue" => "process"}),
                                                          instance_double("Worker", :job => {"queue" => "process"})])

    q = ResqueStatus.to_collectd("queue-master")
    expect(q).to eq(["PUTVAL queue-master/import/queue_length N:1",
                     "PUTVAL queue-master/process/queue_length N:2",
                     "PUTVAL queue-master/dispatch/queue_length N:3",
                     "PUTVAL queue-master/import/current N:1",
                     "PUTVAL queue-master/process/current N:2",
                     "PUTVAL queue-master/dispatch/current N:0"])
  end

end
