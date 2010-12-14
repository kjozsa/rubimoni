class Monitor
  log = Logger.new(STDOUT)
  
  def initialize
    File.readlines('monitor.conf').each do |line|
      elems = line.split
      target = Target.create(:method => elems.shift, :data => elems).
      log.info("Created #{target}")
    end
  end
end

