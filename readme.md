#  Parsing Guest Accounts

This program is to aid adminstration of guest computing accounts for events. After requesting x number of accounts, the details for each account arrive in two separate emails. This program pulls those details together and puts them into a useful format to hand out to the event guests.

The emails have a standard format with key sentences, which are searched for, and then parsed accordingly to extract the required details.

### Edit the Enviroment Variables

Change the value of the variables in environment.rb to suit your needs. These are read by the program to fill in the details of the sites and terms and conditions the users are agreeing to follow when they use the generated account.

### Caveats

The emails are saved from MS Exchange, or Outlook on Windows into one text file, email_messages. In Exchange when multiple messages are selected, then they can be saved to one file, which makes this easier to manage.

A later version of this should also be able to reach into multiple files to gather the details, or to even go into MS Exchange or Outlook.

### Versions

The first version of this as shown in the 'version1' branch was done without methods to understand how it might be done. This works, but is ugly and brittle without any easy paths for creating different output formats.

The second version moves everything to a class with a struct, and extends the use of environment variables to smooth the adaption of the code to different events

### Testing

The test file only checks that the class file runs correctly and provides an example of its use. A better version would provide a same email_messages.txt to provide some validation checks instead of the user eyeballing that the account plus username and password are correct for a few random ones.
