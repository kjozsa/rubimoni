class Monitor
  def initialize
    File.readlines('monitor.conf').each do |line|
      elems = line.split
      Target.create(:method => elems.shift, :data => elems.join(' '))
    end
  end
end

