class GuestAccount
  require "prawn"

#use a struct to hold user account details
Struct.new("User_Account", :account, :username, :password)

  def initialize
    @accounusers = Hash.new
    @accounpass = Hash.new
    @completed_triple = []
  end

  def parse_accounts(filename)
    username = ""
    password = ""
    account = ""
    tempo = ""

    #tempo = tick or tock to keep track of whether user or password

    #open file to read
    File.open(filename, 'r') do |f1|
      while line = f1.gets

        if line.include? "The username is:"
          tempo = "tick"
          spliline = line.split
         # puts line
          username = spliline[3]
        #  puts username
        end

        if line.include? "The temporary password is:"
          spliline = line.split
        #  puts line
          password = spliline[4]
          tempo = "tock"
        end

        if line.include? "The account matching code is :"
          spliline = line.split
          # puts line
          account = spliline[6]
          if tempo == "tick"
            @accounusers.store(account, username)
          else
            @accounpass.store(account, password)
          end
        end
      end
    end

    #take one hash, loop through it, and find matching item from
    #the other hash
    @accounusers.each do |key, value |
      pass = @accounpass.fetch(key)
      @user_account = Struct::User_Account.new(key, value, pass)
    #  puts @user_account.to_s
      @completed_triple << @user_account
    end
    return @completed_triple
  end

  def generate_cvs
  # Create a new file and write to it
   File.open('accounts.csv', 'w') do |f2|
    # use "\n" for new line
    @completed_triple.each do |account|
      f2.puts "\n"
      f2.puts "Welcome to #{ENV['eventname']}! We're glad you could spend the time with us."
      f2.puts "Your account is: #{account.account} with username: #{account.username} and password: #{account.password}"
      f2.puts "The user of this account is required to change this password on first login."
      f2.puts "To change your password:"
      f2.puts "1. Go to our Password Registration portal page: #{ENV['passwordregistrationpage']} to register your security questions."
      f2.puts "2. Login using your IT account username and your temporary password. You must type #{ENV['domain']}\\ before your username, e.g. #{ENV['domain']}\\s02ab3."
      f2.puts "3. Register your security questions."
      f2.puts "4. Once you have registered your security questions, go to our Password Reset portal page: #{ENV['passwordresetpage']}"
      f2.puts "5. Login using your IT account username, answer 3 of your security questions."
      f2.puts "6. Change your temporary password."
      f2.puts "If there are any problems accessing the Password Registration or Reset portal, or completing password reset, the user of this account should contact our IT Service Desk at #{ENV['institution_email']}."
      f2.puts "Or contact one of the event staff, who should be able to help you."
      f2.puts "Computing facilities at the #{ENV['institution']} are governed by terms and conditions: #{ENV['termsandconditionslink']} "
      f2.puts "By logging in the first time you will be accepting these terms and conditions."
      f2.puts " \n \n"
    end
  end
end

  def generate_pdf(completed_triple)
   Prawn::Document.generate("accounts.pdf", :margin => 100 
   ) do

     completed_triple.each do |account| 
      font "Times-Roman"
      font_size 20
      text "Welcome to #{ENV['eventname']}!", :align=> :center
      font_size 16
      text "We're glad you could spend the time with us.", :align=> :center
      text " "
      font_size 12
      text "Your account is: #{account.account} with username: #{account.username} and password: #{account.password}"
      text " "
      text "This is a temporary account that will expire at the end of the final day for the event."
      text "You can use these credentials with multiple devices."
      text " "
      text "1. Connect to the 'wireless help' wifi network."
      text "2. Use the XpressConnect service with the account username. You might be asked to modify the network profile on your device."
      text "3. Login using account username and your password. You must type #{ENV['domain']}\\ after your username, e.g. scb234#{ENV['domain']}."
      text "4. This will ask for your password on the next page, and should then complete."
      text "5. Switch to 'eduroam' network."
      text "6. You should now find you're connected."
      text " "
      text "If there are any problems contact one of the event staff, who should be able to help you."
      text "Computing facilities at the #{ENV['institution']} are governed by terms and conditions: #{ENV['termsandconditionslink']} "
      text "By logging in the first time you will be accepting these terms and conditions."
      text " "
      text "- - - - - - - - - - - - - - - - - - - cut along here for records - - - - - - - - - - - - - - - - - - - - - -"
      text " "
      text "Agreement for #{ENV['eventname']}"
      text "Your account is: #{account.account} with username: #{account.username}"
      text " "
      text " Your name: _________________________________________________________________"
      text " "
      text " "
      text "Signature: ___________________________________________________________________"
      start_new_page 
    end 
   end
  end
end
