class Target  # a log target
  include DataMapper::Resource
  property :id, Serial
  property :method, String  # http200 | ping
  property :data, String  # http://url/
end


class Log   # a log entry
  include DataMapper::Resource

  property :id, Serial
  belongs_to :target
  
  property :measured_at, DateTime
  property :up, Boolean
end
