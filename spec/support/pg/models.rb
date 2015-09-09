module Ecommerce
  class ProductAttributeSet < ::ActiveRecord::Base
    self.table_name = "ecommerce_product_attribute_sets"

    include ::Trax::Model
    include ::Trax::Model::Attributes::Mixin

    mixins :unique_id => { :uuid_prefix => "c2" }

    belongs_to :user, :class_name => "Ecommerce::User"
    belongs_to :product, :class_name => "Ecommerce::Product"
  end

  class ShippingAttributes < ::Ecommerce::ProductAttributeSet
    include ::Trax::Model
    include ::Trax::Model::Attributes::Mixin

    define_attributes do
      struct :specifics, :validate => true do
        string :cost, :default => 0

        validates(:cost, :length => {:minimum => 10})

        enum :service do
          define :usps,  1
          define :fedex, 2
        end

        struct :dimensions, :validate => true do
          string :length
          string :width
          string :height

          validates(:length, :length => {:maximum => 10})
        end
      end
    end
  end

  class Product < ::ActiveRecord::Base
    self.table_name = "ecommerce_products"

    include ::Trax::Model
    include ::Trax::Model::Attributes::Mixin

    mixins :unique_id => { :uuid_prefix => "9a" }

    belongs_to :store, :class_name => "Ecommerce::Store"

    define_attributes do
      string :name, :default => "Whatever" do
        validates(self, :length => { :minimum => 20 })
      end
      boolean :active, :default => true

      enum :status, :default => :in_stock do
        define :in_stock,     1
        define :out_of_stock, 2
        define :backordered,  3
      end
    end
  end

  module Products
    class Shoes < ::Ecommerce::Product
      include ::Trax::Model
      include ::Trax::Model::Attributes::Mixin
    end

    class MensShoes < ::Ecommerce::Products::Shoes
      include ::Trax::Model
      include ::Trax::Model::Attributes::Mixin

      define_attributes do
        string :name, :default => "Some Shoe Name", :define_scopes => true
        boolean :active, :default => true, :define_scopes => true

        struct :custom_fields do
          string :primary_utility, :default => "Skateboarding", :define_scopes => true
          string :sole_material
          boolean :has_shoelaces, :define_scopes => true

          enum :color, :default => :blue, :define_scopes => false do
            define :red,   1
            define :blue,  2
            define :green, 3
            define :black, 4
          end

          enum :size, :default => :mens_9, :define_scopes => true do
            define :mens_6,  1
            define :mens_7,  2
            define :mens_8,  3
            define :mens_9,  4
            define :mens_10, 5
            define :mens_11, 6
            define :mens_12, 7
          end
        end
      end
    end
  end
end