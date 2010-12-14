get '/' do
  @last_refresh = Time.new
  @urls = {}  # url, is_up?
  now = DateTime.now

  Target.all.each do |target|
    result = @urls[target.data] = http200(target.data)
    Log.create(:target => target, :measured_at => now, :up => result)
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
