class SyncDataService

	# def initialize
	# 	puts "in the initialize of sync data service"
	# end

	def sync
		require 'rubygems'
		require 'mechanize'

			# login_url = "http://sis.punjab.gov.pk/user/login"
			 agent = Mechanize.new
			# agent.user_agent_alias = 'Mac Safari'
			# page = agent.get(login_url)
			# form = page.form_with(:action => 'http://sis.punjab.gov.pk/user/login')
			# form.u_username = "33110240"
			# form.u_password = "7961529"
			# page = form.submit
			# puts page.body


		# page = agent.get('http://www.cssforum.com.pk/')
  #   page2 = page.form_with(:action => 'http://www.cssforum.com.pk/login.php?do=login')  do |form|
	 #  	form.field_with(:name => 'vb_login_username').value = 'AwaisTahir'
  # 		form.field_with(:name => 'vb_login_password').value = 'steve56fsd'
		# end.submit

		# page2.link_with(:text => "Click here if your browser does not automatically redirect you.").click

		# page = agent.get('http://sis.punjab.gov.pk/user/login')
  #   page2 = page.form_with(:action => 'http://sis.punjab.gov.pk/user/login')  do |form|
	 #  	form.field_with(:name => 'u_username').value = '33110240'
  # 		form.field_with(:name => 'u_password').value = '7961529'
		# end.submit
		# agent.get("http://sis.punjab.gov.pk/attendance/attendance_summary")
		# page2.link_with(:text => "Click here if your browser does not automatically redirect you.").click

		agent = Mechanize.new
agent.user_agent_alias = 'Windows Chrome'
page = agent.get('http://sis.punjab.gov.pk/user/login')
form = page.form_with(:action => 'http://sis.punjab.gov.pk/user/login')
form.field_with(:name => 'u_username').value = '33110240'
  		form.field_with(:name => 'u_password').value = '7961529'
form.submit


# page2 = agent.get("http://sis.punjab.gov.pk/attendance/attendance_summary")


	end

end