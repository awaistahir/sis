class SyncDataService

	# def initialize
	# 	puts "in the initialize of sync data service"
	# end

	def test
		require 'watir'

		browser = Watir::Browser.new

		browser.goto("http://sis.punjab.gov.pk/user/login")

		form = browser.form(:action => 'https://sis.punjab.gov.pk/user/login')
		unless form.exist?
			form = browser.form(:action => 'http://sis.punjab.gov.pk/user/login')
		end	

		return false unless form.exist?

		form.text_field(name: 'u_username').set("33110240")
		form.text_field(name: 'u_password').set("7961529")
		browser.button(type: 'submit').click
		browser.goto("https://sis.punjab.gov.pk/students/listing")
		browser.table(:class, 'table').trs.each_with_index do |tr, row_no|
			tr.each_with_index do |cell, index|
				if index == 1
					grade = cell.text.strip.split.first.downcase
					section_name = cell.text.strip.split.last.downcase
					begin
						section = Section.where(name: section_name, grade: grade).take!					
					rescue ActiveRecord::RecordNotFound => e
						section = nil
					end
					if section.present?
						puts "yes"
						puts row_no
						# puts tr.html
						# puts browser.link(text: "KATCHI FATIMA").link.wait_until_present.click
					  # puts browser.link(text: "#{cell.text.strip.split.first}").wait_until_present.click
					else
						puts "no"
					end		
				end
			end
		end
		# browser.close
	end

	def sync
		require 'mechanize'
		require 'nokogiri'
		OpenSSL::SSL::SSLContext::DEFAULT_PARAMS[:ciphers] += ':DES-CBC3-SHA'

		agent = Mechanize.new
		agent.user_agent_alias = 'Mac Safari'
		login_url = "http://sis.punjab.gov.pk/user/login"
		page = agent.get(login_url)
		form = page.form_with(:action => 'https://sis.punjab.gov.pk/user/login')
		if form.blank?
			form = page.form_with(:action => 'http://sis.punjab.gov.pk/user/login')
		end

		form.u_username = "33110240"
		form.u_password = "7961529"
		page = form.submit

		# Section.delete_all
		# Student.delete_all

		# sync_section(agent)
		# sync_students(agent)		
		# sync_staff(agent, 1)		
		sync_staff(agent, true)		

	end

	def sync_students(agent)
		students = agent.get("https://sis.punjab.gov.pk/students/listing")
		document = Nokogiri::HTML(students.body)
		table = document.at('table')
		links, sections = [],[]
		table.search('tr').each_with_index do |tr, ii|
			rows = tr.search('td')
			rows.each_with_index do |cell, index|
				if index == 1
					grade =  cell.search('span').first.text.strip.downcase
					section_name = cell.search('span').last.text.strip.downcase
					link = cell.search('a')
					begin
						section = Section.where(name: section_name, grade: grade).take!					
					rescue ActiveRecord::RecordNotFound => e
						section = nil
					end
					if section.present?
						link_text = link.attr('href')
						parse_student(agent, link_text, section.id)
					end
				end  			
			end
		end
	end
	
	def sync_staff(agent, teaching_staff)
		if teaching_staff
			staff = agent.get("https://sis.punjab.gov.pk/teachers/listing")
		end
		document = Nokogiri::HTML(staff.body)
		table = document.at('table')
		names, designation, father_name, cnic, contact = [],[],[],[],[]
		table.search('tr').each do |tr|
			rows = tr.search('td')
			rows.each_with_index do |cell, index|
				if index == 1
					english_name =  cell.text.strip.partition("(").first
					names <<  english_name
				elsif index == 2
					cnic << cell.text.strip	
				elsif index == 3
					contact	 << cell.text.strip	
				elsif index == 4
					designation	 << cell.text.strip	
				end  			

			end
		end
		[names, designation,  cnic, contact]
		# names.each_with_index do |g , i|
		# 	Student.where(name: names[i], dob: dob[i], father_cnic: cnic[i]).first_or_create(name: names[i], dob: dob[i], father_cnic: cnic[i], mobile: contact[i], father_name: father_name[i], section_id: section_id )
		# end
	end

	def sync_section(agent)
		sections = agent.get("https://sis.punjab.gov.pk/sections/listing")
		document = Nokogiri::HTML(sections.body)
		table = document.at('table')
		grades, sections = [],[]
		table.search('tr').each do |tr|
			rows = tr.search('td')
			rows.each_with_index do |cell, index|
				if index == 1
					grades <<  cell.text.strip.downcase
				elsif index == 2
					sections << cell.text.strip.downcase
				end  			
			end
		end
		grades.each_with_index do |g , i|
			Section.where(name: sections[i], grade: grades[i], year: Date.today.year).first_or_create(name: sections[i], grade: grades[i], year: Date.today.year)
		end
	end

	def parse_student(agent, link,section_id)
		student = agent.get(link)
		document = Nokogiri::HTML(student.body)
		table = document.at('table')
		names, dob, father_name, cnic, contact = [],[],[],[],[]
		table.search('tr').each_with_index do |tr, ii|
			rows = tr.search('td')
			rows.each_with_index do |cell, index|
				if index == 2
					names <<  cell.text.strip
				elsif index == 4
					dob << cell.text.strip
				elsif index == 5
					father_name << cell.text.strip	
				elsif index == 6
					cnic << cell.text.strip	
				elsif index == 7
					contact	 << cell.text.strip	
				end  			
			end
		end
		names.each_with_index do |g , i|
			Student.where(name: names[i], dob: dob[i], father_cnic: cnic[i]).first_or_create(name: names[i], dob: dob[i], father_cnic: cnic[i], mobile: contact[i], father_name: father_name[i], section_id: section_id )
		end
	end
end