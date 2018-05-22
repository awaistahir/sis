class Teacher < ApplicationRecord
	mount_uploader :image, AssetUploader
	
	has_many :periods
  has_many :sections, through: :periods
	enum school: { High: 0, Junior: 1 }

	filterrific(
		available_filters: [
			:sorted_by,
			:search_query,
			:with_section_id,
			# :with_created_at_gte
		]
		)

# scope :with_section_id, lambda { |sections_ids|
#     where(:section_id => [*sections_ids])
#   }

def self.options_for_select
    self.schools.map {|k, v| [k.humanize.capitalize, v]}
end

# Sort By All These Options
scope :sorted_by, lambda { |sort_option|
  # extract the sort direction from the param value.
  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
  case sort_option.to_s
  when /^teacher_/
  	order("LOWER(teachers.name) #{ direction }")
  when /^price_/
  	order("students.price #{ direction }")
  when /^author_/
  	order("LOWER(students.name) #{ direction }")
  when /^published_/
  	order("students.published #{ direction }")
  else
  	raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
  end
}


def self.options_for_sorted_by
	[
		['Name - A to Z', 'teacher_asc'],
		['Name - Z to A', 'teacher_desc'],
		# ['Price - Low to High', 'price_asc'],
		# ['Price - High to Low', 'price_desc'],
		# ['Author - A to Z', 'name_asc'],
		# ['Author - Z to A', 'name_desc'],
		# ['Newest to Oldest', 'published_desc'],
		# ['Oldest to Newest', 'published_asc']
	]
end


scope :search_query, lambda { |query|
  # Searches the students table on the 'first_name' and 'last_name' columns.
  # Matches using LIKE, automatically appends '%' to each term.
  # LIKE is case INsensitive with MySQL, however it is case
  # sensitive with PostGreSQL. To make it work in both worlds,
  # we downcase everything.
  return nil  if query.blank?

  # condition query, parse into individual keywords
  teacher_name = query.downcase.split(/\s+/)

  # replace "*" with "%" for wildcard searches,
  # append '%', remove duplicate '%'s
  teacher_name = teacher_name.map { |e|
  	(e.gsub('*', '%') + '%').gsub(/%+/, '%')
  }
  # configure number of OR conditions for provision
  # of interpolation arguments. Adjust this if you
  # change the number of OR conditions.
  num_or_conds = 1
  where(
  	teacher_name.map { |term|
  		"(LOWER(teachers.name) LIKE ? )"
  		}.join(' AND '),
  		*teacher_name.map { |e| [e] * num_or_conds }.flatten
  		)
}

end
