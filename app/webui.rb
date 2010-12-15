get '/' do
  @last_refresh = Log.max(:measured_at)
  @targets = {}  # target, lastlog
  @up, @down = 0, 0
  
  Target.all.each do |target|
    @targets[target] = log = Log.first(:target => target, :measured_at => @last_refresh)
    log[:up] ? @up += 1 : @down += 1
  end

  @upgraph_data = Log.aggregate(:measured_at, :id.count, :up => true).map{|x| x[1]}.join(',')

  haml :index
end


