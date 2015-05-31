class Client < ActiveRecord::Base
	def to_param #overrides
		slug_was
	end

	before_save :default_values
	phony_normalize :phone

	validates :name, presence: true, length: { minimum: 4 }
	validates :slug, presence: true, length: { minimum: 4 },
		uniqueness: { case_sensetive: false }
	validates :phone, length: {minimum: 10, maximum: 10}, allow_blank: true

	def default_values
		self.slug = self.slug.parameterize
	end

	def area_code
		phone == nil ? '' : phone.first(3)
	end

	def phone_prefix
		phone == nil ? '' : phone.slice(3,3)
	end

	def phone_suffix
		phone == nil ? '' : phone.last(4)
	end

	def self.find_by_first_letter(letter)
		where('name LIKE ?', "#{letter}%").order('name ASC')
	end
end
