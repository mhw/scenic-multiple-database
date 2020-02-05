module Scenic
  module Adapters
    # A null adapter, for databases where no view management is needed.
    #
    # This adapter implements the adapter interface, but will raise
    # an exception if any view operations are attempted.
    class Null
      class ViewOperationsNotSupportedError < StandardError
        def initialize
          super("NullAdapter does not support view operations")
        end
      end

      def initialize(connectable = ActiveRecord::Base)
        @connectable = connectable
      end

      def views
        []
      end

      def create_view(name, sql_definition)
        raise ViewOperationsNotSupportedError
      end

      def update_view(name, sql_definition)
        raise ViewOperationsNotSupportedError
      end

      def replace_view(name, sql_definition)
        raise ViewOperationsNotSupportedError
      end

      def drop_view(name)
        raise ViewOperationsNotSupportedError
      end

      def create_materialized_view(name, sql_definition, no_data: false)
        raise ViewOperationsNotSupportedError
      end

      def update_materialized_view(name, sql_definition, no_data: false)
        raise ViewOperationsNotSupportedError
      end

      def drop_materialized_view(name)
        raise ViewOperationsNotSupportedError
      end

      def refresh_materialized_view(name, concurrently: false, cascade: false)
        raise ViewOperationsNotSupportedError
      end
    end
  end

  class NewConfiguration
    attr_writer :database

    def initialize
      @database = nil
      @adapter_map = Hash.new { |h, name| h[name] = Scenic::Adapters::Null.new }
      add_adapter(name: "postgresql", instance: Scenic::Adapters::Postgres.new)
    end

    def add_adapter(name:, instance:)
      @adapter_map[name] = instance
    end

    def database
      return @database if @database
      current_db_config = ActiveRecord::Base.connection_config
      adapter = current_db_config[:adapter]
      @adapter_map[adapter]
    end
  end
end

Scenic.configuration = Scenic::NewConfiguration.new
