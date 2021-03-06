# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  title       :string(255)
#  description :text
#  image_url   :string(255)
#  price       :decimal(8, 2)
#  created_at  :datetime
#  updated_at  :datetime
#

class Product < ActiveRecord::Base
  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true

  validates :image_url, allow_blank: true, 
            format: {    with: %r{\.(gif|jpg|png)\Z}i,
                      message: 'must be a URL for GIF, JPG or PNG image.' 
                    }

  validates :title, length: {minimum: 10}
  validates_length_of :title, minimum: 10, message: "What kind of title is less than 10 chars!?"


  def self.latest
      Product.order(:updated_at).last
  end

  private

      def ensure_not_referenced_by_any_line_item
          if line_items.empty?
              return true
          else
              errors.add(:base, 'Line Items present')
              return false
          end
      end
end
