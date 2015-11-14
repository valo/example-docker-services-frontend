require "sinatra/activerecord"

class User < ActiveRecord::Base
  validates_presence_of :name
end

class SourceCode  < ActiveRecord::Base
  belongs_to :user

  WAITING = "waiting"
  DONE = "done"
end
