class Teacher < ApplicationRecord
	enum school: { High: 0, Junior: 1 }

	# rails_admin do
	# 	create do 
	# 		field :section , :enum do
	# 			enum do
	# 				[['High',1],['Junior',0]]
	# 			end
	# 		end 
	# 	end
	# end
end
