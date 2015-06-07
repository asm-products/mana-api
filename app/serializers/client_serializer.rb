class ClientSerializer < ActiveModel::Serializer
  attributes :slug, :name, :address, :phone, :website
end
