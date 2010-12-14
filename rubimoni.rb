get '/' do
  @last_refresh = Time.new
  @urls = {}  # url, is_up?

  ['http://10.160.254.48/COL-PRODUCTION/BillingAccountService?wsdl', 'http://localhost/nincsilyen'].each do |url|
    @urls[url] = monitor(url)
  end

  haml :index
end

def monitor(url)
  puts "monitoring #{url}"
  begin
    Net::HTTP.get_response(URI.parse(url)).code == '200'
  rescue Exception
    nil
  end
end
