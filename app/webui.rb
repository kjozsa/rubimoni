get '/' do
  @last_refresh = Log.max(:measured_at)
  @targets = {}  # target, lastlog
  @up, @down = 0, 0
  
  Target.all.each do |target|
    @targets[target] = {}
    
    # fetch last down from target
    last_down = Log.last(:target => target, :up => false)
    @targets[target][:last_down] = last_down == nil ? 'never' : last_down[:measured_at]

    # gather up/down statuses
    @targets[target][:log] = log = Log.last(:target => target)
    log[:up] ? @up += 1 : @down += 1
  end
  
  # aggregate logs for line graph
  ag = Log.aggregate(:measured_at, :id.count, :up => true, :measured_at.not => nil, :limit => $watch_mins, :order => :id.desc).map{|x| x[1]}
  @upgraph_data = ([].fill(0, 0, $watch_mins - ag.size) + ag).join ','   # fill up with 0

  haml :index
end


