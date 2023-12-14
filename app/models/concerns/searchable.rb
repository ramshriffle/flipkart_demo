module Searchable
  extend ActiveSupport::Concern

  included do
    include Elasticsearch::Model
    include Elasticsearch::Model::Callbacks

    mapping do
      # Product.reindex
      indexes :title, type: :text
      indexes :description, type: :text
      indexes :category, type: :text
    end

    def self.search(query)
      self.__elasticsearch__.search(query)
    end
  end
end