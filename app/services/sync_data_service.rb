class SyncDataService

	# def initialize
	# 	puts "in the initialize of sync data service"
	# end

	def sync
		require 'nokogiri'
		require 'mechanize'

		agent = Mechanize.new

		login_page = agent.get("http://sis.punjab.gov.pk/user/login")
		form  = login_page.form_with(action: "http://sis.punjab.gov.pk/user/login")
		form.u_username = "33110240"
		form.u_password = "7961529"
		home_page = agent.submit form
		puts home_page
	end

end