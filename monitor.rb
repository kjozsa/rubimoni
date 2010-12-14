class Monitor
  def initialize
    File.readlines('monitor.conf').each do |line|
      next if line.match /^\s*$/
      elems = line.split

      Target.create(:method => elems.shift, :name => elems.shift, :data => elems.join(' '))
    end
  end
end

