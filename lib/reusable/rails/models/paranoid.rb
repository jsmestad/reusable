# The Paranoid module adds model support for "paranoid deletes"
# meaning that you can treat the model as normal, calling destroy
# but the record will simply be flagged as deleted and not removed
# from the storage engine.
#
# This module assumes you have a deleted_at timestamp on your database.
module Reusable::Rails
  module Models
    module Paranoid
      extend ActiveSupport::Concern

      included do
        scope :visible, where(:deleted_at => nil)
        scope :hidden, where("deleted_at IS NOT NULL")
        scope :billable, where('(deleted_at >= ? AND deleted_at <= ?) OR deleted_at IS NULL',
          Date.today.beginning_of_month, Date.today.end_of_month)
      end

      module InstanceMethods
        def reactivate!(attrs={})
          self.attributes = {:deleted_at => nil}.merge(attrs)
          save
        end

        def deactivate!
          update_attributes({:deleted_at => Time.now.utc})
        end

        def is_visible?
          self.deleted_at.blank?
        end

        def is_hidden?
          !is_visible?
        end
      end
    end
  end
end
