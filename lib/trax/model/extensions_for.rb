#trax model attribute dsl/trax core type extensions
module Trax
  module Model
    module ExtensionsFor
      extend ::ActiveSupport::Autoload

      autoload :Base
      autoload :Boolean
      autoload :Enumerable
      autoload :Integer
      autoload :Numeric
      autoload :Set
      autoload :Struct
      autoload :StructFields
      autoload :String
    end
  end
end