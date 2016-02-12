# Require the Flowroute Messaging SDK
require 'flowroute_messaging'

# Instantiate the controller
ctl = FlowrouteMessaging::MessagesController.new('YOUR_API_KEY', 'YOUR_API_SECRET_KEY')
# Create the message object
msg = FlowrouteMessaging::Message.new(to='TO_PHONE_NUMBER', from='FROM_PHONE_NUMBER', content='YOUR_MESSAGE_GOES_IN_HERE')

# Use the controller to send the message
ctl.create_message(msg)