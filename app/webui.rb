get '/' do
  @last_refresh = Log.max(:measured_at)
  @targets = {}  # target, lastlog
  @up, @down = 0, 0
  
  Target.all.each do |target|
    @targets[target] = log = Log.first(:target => target, :measured_at => @last_refresh)
    log[:up] ? @up += 1 : @down += 1
  end
  
  ag = Log.aggregate(:measured_at, :id.count, :up => true, :limit => 10, :order => :measured_at.desc).map{|x| x[1]}
  @upgraph_data = ([].fill(0, 0, 10-ag.size) + ag).join ','
  puts @upgraph_data

  haml :index
end


