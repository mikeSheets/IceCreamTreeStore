class Product < ActiveRecord::Base
  validates_presence_of :name, :permalink
  has_many :order_items, as: :source

  before_validation :set_permalink

  def formatted_image
    "assets/products/" + image.split("/").last
  end

  def formatted_link
    "localhost:3000/products/" + permalink.to_s
  end

  def serializable_hash(options={})
    {
      formatted_image: formatted_image,
      formatted_link: formatted_link
    }.merge(super(options))
  end

  def set_permalink
    self.permalink = name.parameterize
  end
end
