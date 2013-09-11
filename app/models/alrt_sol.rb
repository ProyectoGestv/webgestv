class AlrtSol
  include Mongoid::Document

  field :username, type: String
  field :descr, type: String
  field :tstamp, type: Integer

  embedded_in :alrt
end
