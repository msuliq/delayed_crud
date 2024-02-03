# frozen_string_literal: true

require "delayed_crud/model_extension"

module DelayedCrud
  class Railtie < Rails::Railtie # :nodoc:
    # Include the model extension into ActiveRecord::Base
    ActiveSupport.on_load(:active_record) do
      ActiveRecord::Base.include DelayedCrud::ModelExtension
    end
  end
end
