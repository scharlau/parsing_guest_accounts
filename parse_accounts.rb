#file to parse account details from emails/email_messages.txt and write
# to a csv, or pdf file with coalated account details

#create account_pass and account_user pairs, then match those

account_users = []
account_pass = []
username = ""
password = ""
account = ""
tempo = ""

#tempo = tick or tock to keep track of whether user or pass
# came ahead of the account number

#open file to read
File.open('emails/email_messages.txt', 'r') do |f1|
  while line = f1.gets

    if line.include? "The username is:"
      tempo = "tick"
      split_line = line.split
      puts line
      username = split_line[3]
      puts username
    end

    if line.include? "The temporary password is:"
      split_line = line.split
      puts line
      password = split_line[4]
      tempo = "tock"
      puts password
    end

    if line.include? "The account matching code is :"
      split_line = line.split
    #  puts split_line
      account = split_line[6]
      puts account
      if tempo == "tick"
        account_users << {account => username}
      else
        account_pass << {account => password}
      end
    end
  end
end

#take one array, loop through it, and find matching item from
#the other array


# Create a new file and write to it
File.open('accounts.csv', 'w') do |f2|
  # use "\n" for two lines of text
  f2.puts account_users.to_s
  f2.puts account_pass.to_s
end
