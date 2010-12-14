class Log
  include DataMapper::Resource

  property :id, Serial
  property :measured_at, DateTime
  property :method, String  # http200
  property :data, String  # http://url/
  property :result, Boolean
end
