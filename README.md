# flowroute-messaging-ruby
## What is it?

Flowroute-messaging-ruby is a ruby SDK that provides methods for sending outbound SMSs with [Flowroute's](https://www.flowroute.com) API v2. These methods can be used to accomplish the following:

* Send outbound SMS
* Retrieve MDRs (message detail records)

## Documentation 
The full documentation for Flowroute's v2 API is available at [flowroute.readme.io](https://flowroute.readme.io/).

## How To Install 

The SDK uses the UniRest ruby library, which will need to be installed before you can use the SDK. To install this package, open a terminal session and execute the following commands

	cd flowroute-messaging-ruby/
	gem build flowroute_messaging.gemspec
	gem install flowroute_messaging-1.0.gem

> Note: You will need to be connected to the internet in order to install the required packages
  
## How To Get Setup

The following shows how to import the SDK and setup your API credentials.

1) Import the SDK module:

	require 'flowroute_messaging/'

> Depending on your file system structure, you may need to explicitly state the location of the flowroute_messaging SDK. 
   
2) Configure your API Username and Password from [Flowroute Manager](https://manage.flowroute.com/accounts/preferences/beta/).
 > If you do not have an API Key contact support@flowroute.com:

	ctl = FlowrouteMessaging::MessagesController.new('YOUR_API_KEY', 'YOUR_API_SECRET_KEY')		

## List of Methods and Example Uses

### messages_controller

The APIController contains the methods neccesary to both send outbuond SMSs and to retrieve MDRs.

#### create_message message

The create_message method is used to send outbound messages from SMS enabled Flowroute numbers.

| Parameter | Required | Usage                                                                                |
|-----------|----------|--------------------------------------------------------------------------------------|
| message   | True     | The message parameter that includes your To Number, From Number, and Message Content |

##### Example Usage

	msg = FlowrouteMessaging::Message.new(to='19515555555', from='12065555555', content='Obviously you're not a golfer.')
	ctl.create_message(msg)
	
#### get\_message\_lookup record_id

The get\_message\_lookup method is used to retrieve a MDR (message detail record).

| Parameter | Required | Usage                                                 |
|-----------|----------|-------------------------------------------------------|
| recordId  | True     | The ID for the record that you would like to retrieve |

##### Example Usage

	recID = 'mdr1-aab41ddde40742e1bea286116a320agf'
	print ctl.get_message_lookup(recID)