get '/' do
  @last_refresh = DateTime.now
  @targets = {}  # url, is_up?
  @up, @down = 0, 0
  
  Target.all.each do |target|
    is_up = @targets[target] = http200(target.data)
    Log.create(:target => target, :measured_at => @last_refresh, :up => is_up)
    is_up ? @up += 1 : @down += 1
  end

  haml :index
end

def http200(url)
  puts "monitoring #{url}"
  begin
    Net::HTTP.get_response(URI.parse(url)).code == '200'
  rescue Exception
    nil
  end
end
