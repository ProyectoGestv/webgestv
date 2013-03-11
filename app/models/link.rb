# -*- encoding : utf-8 -*-

class Link
  include Mongoid::Document
  validates_presence_of :desc, message: 'Debe escribir una descripción de la conexión.'
  validates_presence_of :link_a, :link_b, message: 'Debe seleccionar un recurso.'
  field :desc, type: String
  field :link_a, type: String
  field :link_b, type: String
end
