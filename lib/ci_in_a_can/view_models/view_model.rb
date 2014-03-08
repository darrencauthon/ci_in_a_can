module CiInACan

  module ViewModels

    class ViewModel

      def initialize value
        @value = value
      end

      def the_original_value
        @value
      end

      def method_missing(meth, *args, &blk)
        @value.send(meth)
      end

    end

  end

end
