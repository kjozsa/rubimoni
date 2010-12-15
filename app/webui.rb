get '/' do
  p Log.class
  @last_refresh = Log.max[:measured_at]
  @targets = {}  # url, is_up?
  @up, @down = 0, 0
  
  Target.all.each do |target|
    @targets[target] = log = Log.first(:target => target, :measured_at => @last_refresh)
    log[:up] ? @up += 1 : @down += 1
  end

  @upgraph_data = nil  

  haml :index
end


