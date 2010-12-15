class Target  # a log target
  include DataMapper::Resource

  property :id, Serial
  property :name, String  # eg. esb_prod 
  property :method, String  # eg. http200
  property :data, String  # eg. http://url/
end


class Log   # a log entry
  include DataMapper::Resource

  property :id, Serial
  belongs_to :target
  
  property :measured_from, DateTime
  property :measured_at, DateTime
  property :up, Boolean
end
