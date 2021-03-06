# == Schema Information
#
# Table name: cost_centers
#
#  id                :bigint(8)        not null, primary key
#  customer_id       :integer
#  contact_id        :integer
#  description       :text
#  start_date        :date
#  end_date          :date
#  quotation_number  :string
#  engineering_value :float
#  viatic_value      :float
#  execution_state   :string
#  invoiced_state    :string
#  service_type      :string
#  code              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  count             :integer
#

class CostCenter < ApplicationRecord
	has_many :reports  , dependent: :destroy
	has_many :customer_reports , dependent: :destroy
	has_many :sales_orders, dependent: :destroy
	has_many :customer_invoice, dependent: :destroy
	
	belongs_to :customer, optional: :true
	belongs_to :contact, optional: :true
	before_save :create_code

	def create_code

		count = CostCenter.where(service_type: self.service_type).maximum(:count)
		customer_prefix = Customer.find(self.customer_id).code
		puts count
		puts count.blank?

		self.count = count == 0  || count.blank? || count.nil?   ?  1 :  count
		puts self.count
		puts "countttttttttttttttttttttt"
		prefix = self.service_type.slice(0,3).upcase
		self.code = prefix + "-" + customer_prefix +"-" + self.count.to_s + "-" + Time.now.year.to_s
		
	end

end
