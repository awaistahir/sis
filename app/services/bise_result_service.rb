class BiseResultService

	# def initialize
	#  "in the initialize of sync data service"
	# end

	def search_result
		require 'watir'

		
		# (5706..570666).each do |rollno|	
		(455209..455214).each do |rollno|	
			browser = Watir::Browser.new
			browser.goto("http://result.bisefsd.edu.pk/ResultCurrent.aspx")
			form = browser.form(:id => 'form1')

			form.text_field(name: 'ctl00$ContentPlaceHolder1$txtRollNo').set(rollno)
			browser.button(type: 'submit').click
			puts roll_no = browser.span(:id => "lblRollNoValue").text
			puts student_name = browser.span(:id => "lblNameValue").text
			puts father_name = browser.span(:id => "lblFatherValue").text
			puts final_notification = browser.span(:id => "lblNotification").text.split(":").last.strip

			section = Section.find(153)
			student = Student.create(name: student_name,father_name: father_name, section: section)

			bise_exam_master = BiseExamMaster.create(student: student, remarks: final_notification, roll_no: roll_no )
			subject,max_marks,part1,part2,practical,total_remarks = '','','','','',''

			browser.table(:class, 'table').trs.each_with_index do |tr, row_no|
				unless  row_no == 0				
					tr.each_with_index do |cell, index|
						if index == 1
							subject = cell.text.strip
						elsif index == 2
							max_marks = cell.text.strip.split.first
						elsif index == 3
							part1 = cell.text.strip.split.first
						elsif index == 4

							part2 = cell.text.strip.split.first					
							practical =  cell.text.strip.split.count > 1 ? cell.text.strip.split.last : ''
						elsif index == 5
							total_remarks =  cell.text.strip
						end				
					end

					bise_exam_master.bise_exam_details.create(subject: subject, max_marks: max_marks, part1: part1, part2: part2, practical: practical, total_remarks: total_remarks)

			
					
				end
			end
		end
	end
end