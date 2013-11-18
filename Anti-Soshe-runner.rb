class Call
	ACCOUNT_SID = ENV["TWILIO_SID"]
	AUTH_TOKEN = ENV["TWILIO_TOKEN"]
	
	def initialize
		@account = Twilio::REST::Client.new(ACCOUNT_SID, AUTH_TOKEN)
	end

  def run
    introduce
    ask_minutes
    ask
  end

	def make_call
		call = @account.calls.create({
			:url => "http://joeylabs.com/projects/twilio/voice.xml",
			:from => '+13473345606', 
			:to => '6466757303'
		})
		puts call.to
	end
	
	def introduce
		puts "\nHello #{name}! Welcome to ANTI-SOSHE, your social eject button."
		ask_minutes
	end
	def ask_minutes
		puts "How many minutes from now would you like us to call you so you can excuse yourself?"
		@minutes = gets.to_i
		ask
	end
	def confirm_minutes
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
				ask_minutes
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
    if @minutes.zero?
      return puts "\n\nSorry, we need at least a minute to schedule your call."
    end
    puts "\n\nSchedule the call in #{@minutes} #{pluralize(@minutes, 'minute')}?"
    confirm_minutes
	end

  private

  def pluralize(count, word)
    if count != 1
      word + 's'
    else
      word
    end
  end
end











    