class Monitor
  # load monitor config, create targets
  def initialize
    now = DateTime.now - 0.00001

    File.readlines('monitor.conf').each do |line|
      next if line.match /^\s*$/
      elems = line.split
      method, name, data = elems.shift, elems.shift, elems.join(' ')

      target = Target.first(:name => name) || Target.create(:name => name)
      target.update(:method => method, :data => data)
      Log.create(:target => target, :measured_from => now)
    end
    monitor
  end

  # called by scheduler
  def monitor
    now = DateTime.now

    Target.all.each do |target|
      up = http200(target.data)
      log = Log.last(:target => target)
      
      if log[:up] == up 
        log.update(:measured_at => now)
      else 
        Log.create(:target => target, :measured_from => now, :measured_at => now, :up => up)
      end
    end
  end

  # monitor http, check for response code 200
  def http200(url)
    begin
      Net::HTTP.get_response(URI.parse(url)).code == '200'
    rescue Exception
      false
    end
  end
end

