class Call
	def initialize name="Stranger"
		@name = name

		@account_sid = ENV["TWILIO_SID"]
		@auth_token = ENV["TWILIO_TOKEN"]
		@client = Twilio::REST::Client.new(@account_sid, @auth_token)
		@account = @client.account
		
		introduce

		
	end

	def name
		@name
	end

	def name=(name)
		@name = name
	end
	def makeCall
		call = @account.calls.create({
			:url => "http://joeylabs.com/projects/twilio/voice.xml",
			:from => '+13473345606', 
			:to => '6466757303'
		})
		puts call.to
	end
	
	def introduce
		puts "\nHello #{name}! Welcome to ANTI-SOSHE, your social eject button."
		askMinutes
	end
	def askMinutes
		puts "How many minutes from now would you like us to call you so you can excuse yourself?"
		@minutes = gets.chomp.to_i
		ask
	end
	def confirmMinutes
		confirm = gets.chomp.downcase

			if yesArray.include?(confirm)

					if @minutes == 1
						
						timeCondition = "a minute"
					else
						timeCondition = "#{@minutes} minutes."
					end
					puts "\nOkay, great! We'll schedule your call to occur #{timeCondition}"
					queue
			elsif noArray.include?(confirm)
				askMinutes
			else 
				puts "\n\nWe did not understand your command. Goodbye.\n"
			end
	end
	def queue
		sleep @minutes
		makeCall
	end
	def yesArray
		@yesArray = ["true", "t", "yes", "yeah", "yep", "ya", "yah", "y", "yea"]
	end
	def noArray
		@noArray = ["false", "f", "no", "naw", "nope", "na", "nah", "n"]
	end
	def ask
		if @minutes == 0
			puts "\n\nSorry, we need at least a minute to schedule your call."
			askMinutes
		elsif @minutes == 1
			puts "\n\nSchedule the call in #{@minutes} minute?"
			confirmMinutes
		else
			puts "\n\nSchedule the call in #{@minutes} minutes?"
			confirmMinutes
		end
	end
end











    