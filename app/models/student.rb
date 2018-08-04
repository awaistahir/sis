class Student < ApplicationRecord


	belongs_to :section
  has_many :bise_exam_masters




def result(student_class)
  self.bise_exam_masters.where(student_class: student_class).first
end

def result_master
    self.result(10)
end

def result_details
   result_master.bise_exam_details unless result_master.blank?
end


	filterrific(
		# default_filter_params: { sorted_by: 'created_at_desc' },
		available_filters: [
			:sorted_by,
			:search_query,
			:with_section_id,
			# :with_created_at_gte
		]
		)

scope :with_section_id, lambda { |sections_ids|
    where(:section_id => [*sections_ids])
  }

# Sort By All These Options
scope :sorted_by, lambda { |sort_option|
  # extract the sort direction from the param value.
  direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
  case sort_option.to_s
  when /^student_/
  	order("LOWER(students.name) #{ direction }")
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
		['Name - A to Z', 'student_asc'],
		['Name - Z to A', 'student_desc'],
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
  student_name = query.downcase.split(/\s+/)

  # replace "*" with "%" for wildcard searches,
  # append '%', remove duplicate '%'s
  student_name = student_name.map { |e|
  	(e.gsub('*', '%') + '%').gsub(/%+/, '%')
  }
  # configure number of OR conditions for provision
  # of interpolation arguments. Adjust this if you
  # change the number of OR conditions.
  num_or_conds = 1
  where(
  	student_name.map { |term|
  		"(LOWER(students.name) LIKE ? )"
  		}.join(' AND '),
  		*student_name.map { |e| [e] * num_or_conds }.flatten
  		)
}

end
