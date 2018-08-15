#  Parsing Guest Accounts

This program is to aid adminstration of guest computing accounts for events. After requesting x number of accounts, the details for each account arrive in two separate emails. This program pulls those details together and puts them into a useful format to hand out to the event guests.

### Edit the Enviroment Variables
Change the value of the variables in environment.rb to suit your needs. These are read by the program to fill in the details of the sites and terms and conditions the users are agreeing to follow when they use the generated account.

### Caveats

The emails are saved from MS Exchange, or Outlook on Windows into one text file, email_messages. In Exchange when multiple messages are selected, then they can be saved to one file, which makes this easier to manage.

A later version of this should also be able to reach into multiple files to gather the details, or to even go into MS Exchange or Outlook.
