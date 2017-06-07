# Monkey patch Audit model
module Audited
  class Audit < ::ActiveRecord::Base

    # override this method to track user model and cache username at the same time
    def user_as_string=(user)
      self.user_as_model = self.username = nil

      if user.is_a?(::ActiveRecord::Base)
        self.user_as_model = user
        self.username = user.name
      else
        self.username = user
      end
    end
    alias_method :user=, :user_as_string=

  end
end