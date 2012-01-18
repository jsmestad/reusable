# This CounterCache module provides support for an ActiveRecord
# type counter cache in Mongoid.
#
# class Reviews
#   include Mongoid::Document
#   include Reusable::Mongoid::CounterCache
#
#   counter_cache name: 'profiles', field: 'reviews_count'
#   belongs_to_related :profile
# end
module Reusable::Mongoid
  module CounterCache
    extend ActiveSupport::Concern

    module ClassMethods
      def counter_cache(options)
        name = options[:name]
        counter_field = options[:field]

        after_create do |document|
          relation = document.send(name)
          relation.collection.update(relation._selector, {'$inc' => {counter_field.to_s => 1}})
        end

        after_destroy do |document|
          relation = document.send(name)
          relation.collection.update(relation._selector, {'$inc' => {counter_field.to_s => -1}})
        end
      end
    end

  end
end
