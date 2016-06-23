# flowroute-messaging-ruby

**flowroute-messaging-ruby** is a Ruby SDK that provides methods to send an outbound SMS from a Flowroute phone number and also to retrieve a Message Detail Records (MDR). These methods use **v2** (version 2) of the [Flowroute](https://www.flowroute.com) API.

These methods can be used to accomplish the following:

*	Send an outbound SMS
*	Retrieve a message detail record (MDR)

**Note:** This SDK does not cover searching for a set of MDRs based on a date range. For searching on a date range, see [Look up a Set of Messages](https://developer.flowroute.com/docs/lookup-a-set-of-messages) on the Flowroute Developer Portal.

## Documentation 
The full documentation for v2 of the Flowroute API is available [here](https://developer.flowroute.com/v2.0/docs).

##Before you begin

The following are required before you can deploy the SDK.

### Have your API credentials

You will need your Flowroute API credentials (Access Key and Secret Key). These can be found on the **Preferences > API Control** page of the [Flowroute](https://manage.flowroute.com/accounts/preferences/api/) portal. If you do not have API credentials, contact <mailto:support@flowroute.com>.

### Know your Flowroute phone number

To create and send a message, you will need your Flowroute phone number, which should be enabled for SMS. If you do not know your phone number, or if you need to verify whether or not it is enabled for SMS, you can find it on the [DIDs](https://manage.flowroute.com/accounts/dids/) page of the Flowroute portal.

### Get a code text editor

Steps in this SDK describe creating one or more script files that allow you to execute the methods. Script files can be created either using a terminal window shell or through using a code text editor. For example, *Sublime Text*. 

## Install the required libraries

> **Note:** You must be connected to the Internet in order to install the required libraries.

The SDK uses the UniRest Ruby library, which must be installed before you can use the SDK. 

1. Open a terminal session. 

2. If needed, create a parent directory folder where you want to install the SDK.
 
3. Go to the newly created folder, and run the following:

 	`git clone https://github.com/flowroute/flowroute-messaging-ruby.git`
 	
 	The `git clone` command clones the **flowroute-messaging-ruby** repository as a sub directory within the parent folder.
 	
4.	Change directories to the newly created **flowroute-messaging-ruby** directory.

5.	Run the following:

		gem build flowroute_messaging.gemspec
		gem install flowroute_messaging-1.0.gem

6.	Import the SDK.

 
## Create a script to import the SDK

Importing the SDK requires that you run commands either by creating and running a script or through the shell. The following instructions describe importing the SDK and running the `messages_controller` by creating and running a script.

>**Note:** The following steps describe creating a new Ruby script. However, a demo script, **demo_send.rb**, was installed when the the libraries installed. This file contains the required lines that only need to be modified with your credentials and details for the message to send. If you want to use this script, modify the fields as described below, then run the script from the command line.  

1.	Using a code text editor — for example, *Sublime Text* — create a new file.

2.	Add the following Ruby `require` line at the top of the file:

		#Require Flowroute Messaging
		require 'flowroute_messaging'
		
3.	Next, add the lines to pass your API credentials to the Controller:

		#Pass your API credentials
		ctl = FlowrouteMessaging::MessagesController.new('YOUR_API_KEY', 'YOUR_API_SECRET_KEY')   

4.	Replace `YOUR_API_KEY` and `YOUR_API_SECRET_KEY` with your own Access Key and Secret Key.

5.	Add the [MessagesController](#controller) methods.

6.	Save the file in the top-level **flowroute-messaging-ruby** directory with a **.rb** extension. For this example, the file is named **createmsg.rb**.

7.	From the **flowroute-messaging-ruby** directory in a terminal window, run the following to invoke the methods within the file:

		ruby createmsg.rb
		
### Example Ruby file
	
The following shows an example file, **createmsg.rb**, that contains all Controller methods:
	
	#Require Flowroute Messaging
	require 'flowroute_messaging'

	#Pass your API credentials
	ctl = FlowrouteMessaging::MessagesController.new('12345678', 'm8axLA45yds7123488aOQ7BshaADg6vr')

	#Create, send and print the message
	msg = FlowrouteMessaging::Message.new(to='To Phone Number', from='From Phone Number', content='Message content')
	ctl.create_message(msg)
	print ctl.create_message(msg)	
		
	#Get the MDR
	recID = 'recordIdentifier'
	print ctl.get_message_lookup(recID))
		
## MessagesController<a name=controller></a>

The `MessagesController` contains the methods required to send outbound SMS texts and to retrieve MDRs:

*	[`create_message`](#createmessage)— used to send outbound messages from an SMS-enabled Flowroute number.
* 	[`get_message_lookup`](#getmessage)— used to retrieve the MDR for a specified message.

### `create_message`<a name=createmessage></a>

The `create_message` function is used to send outbound messages from an SMS-enabled Flowroute number. 

#### Usage

Add the following lines to your Ruby file to create the message, send the message, and then print the message record identifier to the screen:

	#Create, send, and print a message
	msg = FlowrouteMessaging::Message.new(to='To Phone Number', from='From Phone Number', content='Message content.')
	ctl.create_message(msg)
	print ctl.create_message(msg)
	
The method is composed of the following variables and parameters:

| Parameter | Required | Type |Usage   |                                                                             
|-----------|----------|-------|--------------------------------------------------------|
| `msg`   | True     | string| The variable name, which is composed of the `Message.new()` model, described below. The variable name can be of any length. The variable name created here must also be passed in `ctl.create_message()` and `print ctl.create_message(msg)`.<br>For this method, `msg` is used. 

#####`Message.new*()` parameters

The following describe the parameters that compose the `Message.new()` object:

| Parameter | Required | Type| Usage                |                                                       
|----------|----------|------|----------------------------------------------------------------------|
| `To Phone Number`     | True     | string |Target phone number for the message. Must use an _1NPANXXXXXX_ E.164 format. | 
|`From Phone Number`|True|string| Source phone number. It must be a number registered with Flowroute, must be SMS-enabled, and must use an _1NPANXXXXXX_ E.164 format.|
| `Message content`| True   |string | The message itself. An unlimited number of characters can be used, but message length rules and encoding apply. See [Message Length & Concatenation](https://developer.flowroute.com/docs/message-length-concatenation) for more information. | 

#### Example usage

	#Create, send, and print a message
	msg = FlowrouteMessaging::Message.new(to='15305557784', from='18444205700', content='You're obviously not a golfer.')
	ctl.create_message(msg)
	print ctl.create_message(msg)

#### Response messages<a name=send_rsp></a>

One of the following will occur:

1.	If `print ctl.create_message(msg)` was not added to the script, no confirmation response is returned for a sent message. Response error messages can be returned, however.
 
2.	 If `print ctl.create_message(msg)` was added to the script, a successful response returns the message record identifier, as shown in the following example:

		{"data": {"id": "mdr1-fab29a740129404a8ca794efc1359e12'}}
	
	>**Note:** See [`get_message_lookup`](#getmessage) for information on using the identifier to retrieve an MDR.

3.	If an error is encountered, an error response is returned. The message is not sent. 

#### Error response

| Error code | Message | Description                                                 |
|-------|----------|-------------------------------------------------------|
|`401`   |UNAUTHORIZED|The API credentials are incorrect.
|`403`  | FORBIDDEN  | The `from` phone number is not authorized.|
|`500`| HTTP Response Not OK | The `to` phone number is not an 11-digit number using an E.164 format.|

	
### `get_message_lookup`<a name="getmessage"></a>

The `get_message_lookup` method is used to retrieve a single MDR by passing the record identifier of a previously sent message. Before running the method you must have retrieved a message ID using the `create_message` method.

#### Usage

Add the following lines to your Ruby file:

	#Get the MDR
	recID = 'recordIdentifier'
	print ctl.get_message_lookup(recID))

It supports the following parameters:

| Parameter | Required | Type |Usage                                                 |
|-----------|----------|-------|------------------------------------------------|
|`recID`   | True |string  | Variable that identifies the `Record Identifier`. This variable can use any alphanumeric character and can be of any length. For this example, `recID` is used.
| `recordIdentifier`      | True| string     | The identifier of an existing record to retrieve, from the `create_message` method. The value should include the`mdr1-`prefix. |

#### Example usage

	#Get the MDR
	recID = 'fab29a740129404a8ca794efc1359e12'
	print ctl.get_message_lookup(recID))


#### Example response		

On successfully invoking the method, the MDR is returned as shown in the following example. If an error is encountered while invoking the message, an [error response message](#errorgetmsg) is returned.
	
>**Note:** The following shows example formatting only. It is not intended to show the formatting of your own output.

		{"data"=>
			{"attributes"=>				{"body"=>"You're obviously not a golfer.", 				"direction"=>"outbound", 				"timestamp"=>"2016-06-01T19:21:16.396909+00:00", 				"amount_nanodollars"=>4000000, 
				"from"=>"18444205700", 				"message_encoding"=>0, 				"has_mms"=>false, 				"to"=>"15305557784",				"amount_display"=>"$0.0040", 				"callback_url"=>nil, 				"message_type"=>"long-code".
 				}, 			"type"=>"message", 			"id"=>"mdr1-fab29a740129404a8ca794efc1359e12"
			}		}	
###### Response message field descriptions

The following information is returned in the response message:

|Parameter | Description                                                 |
|-----------|-------------------------------------------------------------|
| `data`  | Object composed of `attributes`, `type`, and `id`. |
|`attributes`    |Object composed of the following:
|  | <ul><li>`body`: The content of the message.<li>`direction`:  The direction of the message. For a sent message, this is `outbound`. For a received message this is`inbound`.<li>`timestamp`: Date and time, to the second, on which the message was sent. This field displays UTC time using an ISO 8601 format.<li>`amount_nanodollars`: The cost of the message in nanodollars. Because Flowroute uses eight decimal points of precision, the amount in nanodollars is the USD`amount_display` value multipled by 100,000,000 (one hundred million) for a corresponding whole number. <li>`from`: The Flowroute SMS-enabled number from which the message was sent.<li>`message_encoding`: Indicates the encoding type, which will be either `0` (UTF-8) or `8` (UCS-2). See [Message Length & Concatenation](https://developer.flowroute.com/docs/message-length-concatenation) for more information. <li>`has_mms`: Boolean indicating whether or not the message includes a multimedia file. `true` indicates yes, while `false` indicates no. Currently, MMS is not supported; therefore, the default value for this field will always be `false`.  <li>`to`: The phone number to which the message was sent. <li>`amount_display`: The total cost of the message in USD. If a message was broken into multiple pieces due to concatenation, this amount will be the total amount for all message pieces. This field does _not_ display out to eight decimal points. See _Message cost_ in [Message Length & Concatenation](https://developer.flowroute.com/docs/message-length-concatenation) for more information. <li>`callback_URL`The callback URL defined for the Flowroute number on the [Preferences > API Control](https://manage.flowroute.com/accounts/preferences/api/) page, the URL appears in this field; otherwise, the value is `nil`.  <li>`message_type`: Indicates the type of message, either `long-code` or `toll-free`. If the message was sent to or received from another phone number, this field displays `long-code`; if sent to or received from a toll-free number, this field displays `toll-free`. </li></ul>| 
|`type`| Defines what the object is. Because SMS is the only supported object type, this field will always display `message`.|
|`id` | The unique record identifier of a sent message, generated from a successful `create_message`.|                      

#####Error response<a name=errorgetmsg></a>

| Error code | Message | Description                                                 |
|-------|----------|-------------------------------------------------------|
|500 |Response Not OK|This error is most commonly returned when the `id` passed in the method is incorrect.|
	