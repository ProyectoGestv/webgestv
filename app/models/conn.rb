class Conn
  include Mongoid::Document
  field :ip, type: String
  field :port, type: Integer
  embedded_in :man_rsc
end
