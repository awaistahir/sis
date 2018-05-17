class QuestionsController < ApplicationController

	def print
		require "prawn"
		require 'prawn/table'

		Prawn::Document.generate("jinnah_homework_6th_2018.pdf", :page_size => "A4",) do
			Student.where("section_id = 3").each do |std|
				font_size 18
				font "Helvetica", style: :bold

				text "Summer Vacations Homework (Computer Education)" , :align => :center
				font_size 16
				font "Helvetica", style: :normal
				stdArray = [std.name, std.father_name, std.section.name]
				table([ ["Name", "Father Name ",  "Section"],
					stdArray.map(&:titleize)], :column_widths => [220, 200, 100])
				move_down 20
				Question.where(course_id = '1').each_with_index   do |q, i|
					canvas do
						fill_circle [bounds.left, bounds.top], 35
						fill_circle [bounds.right, bounds.top], 35
						fill_circle [bounds.right, bounds.bottom], 35
						fill_circle [0, 0], 35
					end
					font_size 14
					question_type =  q.read_attribute_before_type_cast(:question_type) 
					if question_type == 0
						text "Q)#{i+1}: "+ q.statment
						move_down 18
						stroke_horizontal_rule
						move_down 22
						stroke_horizontal_rule
						move_down 22
						stroke_horizontal_rule
						move_down 22
					elsif question_type == 1  
						text "Q)#{i+1}: "+ q.statment
						move_down 18
						image q.image.path, :width => 450, :height => 200,  :position => :center
						move_down 22
					elsif question_type == 2 
					 move_down 12
					 image q.image.path, :width => 450, :height => 140,  :position => :center
							
					end
				end
				start_new_page 
			end 		  
		end
		render plain: "OK"
	end
end
