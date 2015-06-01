module PhoneStringsConcern
	extend ActiveSupport::Concern

	def area_code
		self.phone == nil ? '' : self.phone.first(3)
	end

	def phone_prefix
		phone == nil ? '' : phone.slice(3,3)
	end

	def phone_suffix
		phone == nil ? '' : phone.last(4)
	end

end