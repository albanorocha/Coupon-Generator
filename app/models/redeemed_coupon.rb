class RedeemedCoupon < ActiveRecord::Base
  belongs_to :coupon
  belongs_to :user

  validates_presence_of :client_name
  validates :client_email, :uniqueness => {:scope => :coupon_id}

  validates :client_email,
        :presence => true,
        :format => { :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/ ,
                     :message => 'E-mail inválido! Por favor, forneça um endereço de e-mail válido'},
        :on => :create
end
