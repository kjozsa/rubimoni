class Monitor
  # load monitor config, create targets
  def initialize
    File.readlines('monitor.conf').each do |line|
      next if line.match /^\s*$/
      elems = line.split

      Target.create(:method => elems.shift, :name => elems.shift, :data => elems.join(' '))
    end
    monitor
  end

  # called by scheduler
  def monitor
    now = DateTime.now

    Target.all.each do |target|
      Log.create(:target => target, :measured_at => now, :up => http200(target.data))
    end
  end

  # monitor http, check for response code 200
  def http200(url)
    puts "monitoring #{url}"
    begin
      Net::HTTP.get_response(URI.parse(url)).code == '200'
    rescue Exception
      nil
    end
  end
end

