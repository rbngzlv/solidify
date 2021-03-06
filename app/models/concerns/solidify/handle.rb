module Solidify
  module Handle
    extend ActiveSupport::Concern
    include ActionDispatch::Routing::PolymorphicRoutes
    include Solidify::Engine.routes.url_helpers

    included do
      extend FriendlyId
      friendly_id :name, use: %i(finders slugged)

      def self.handle_to_records_array
        all.each_with_object({}) do |record, hash|
          hash[record.handle] = record
        end
      end

      def url
        polymorphic_path(self)
      end

      alias_attribute :handle, :slug
      alias_attribute :title, :name
    end
  end
end
