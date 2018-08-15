#file to parse account details from emails/email_messages.txt and write
# to a csv, or pdf file with coalated account details

#create account_pass and account_user pairs, then match those together

account_users = Hash.new
account_pass = Hash.new
completed_triple = []
username = ""
password = ""
account = ""
tempo = ""

#tempo = tick or tock to keep track of whether user or password

#open file to read
File.open('emails/email_messages.txt', 'r') do |f1|
  while line = f1.gets

    if line.include? "The username is:"
      tempo = "tick"
      split_line = line.split
    #  puts line
      username = split_line[3]
    #  puts username
    end

    if line.include? "The temporary password is:"
      split_line = line.split
  #    puts line
      password = split_line[4]
      tempo = "tock"
#      puts password
    end

    if line.include? "The account matching code is :"
      split_line = line.split
    #  puts split_line
      account = split_line[6]
  #    puts account
      if tempo == "tick"
        account_users.store(account, username)
      else
        account_pass.store(account, password)
      end
    end
  end
end

#take one hash, loop through it, and find matching item from
#the other hash
account_users.each do |key, value |
#  puts 'hash looping'
  puts "#{key} and #{value}"
  pass = account_pass.fetch(key)
  puts pass
  completed_triple << [key, value, pass]

end

# Create a new file and write to it
File.open('accounts.csv', 'w') do |f2|
  # use "\n" for two lines of text
  f2.puts account_users.to_s
  f2.puts account_pass.to_s
  f2.puts completed_triple.to_s
  f2.puts "user accounts are:"
  completed_triple.each do |account|
    f2.puts ""
    f2.puts "account: #{account[0]} with username: #{account[1]} and password: #{account[2]}"
    f2.puts "The user of this account is required to change this password on first login."
    f2.puts "To change your password:"
    f2.puts "1. Go to our Password Registration portal page: xxxx to register your security questions."
    f2.puts "2. Login using your IT account username and your temporary password. You must type uoa\ before your username, e.g. uoa\s02ab3."
    f2.puts "3. Register your security questions."
    f2.puts "4. Once you have registered your security questions, go to our Password Reset portal page: xxxx"
    f2.puts "5. Login using your IT account username, answer 3 of your security questions."
    f2.puts "6. Change your temporary password."
    f2.puts "If there are any problems accessing the Password Registration or Reset portal, or completing password reset, the user of this account should contact our IT Service Desk at xxxx <mailto:xxxx> .
    Or log a call with MyIT self-service at xxxx- login using the account username and temporary password, select the call option 'Other', then follow the onscreen instructions."
    f2.puts "Computing facilities at the University of Aberdeen are governed by terms and conditions:    xxxx "
    f2.puts "By logging in the first time you will be accepting these terms and conditions."
    f2.puts ""
  end
end
