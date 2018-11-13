# clients

## Firewall settings

Add the GPO settings to enable the firewall:

* On Domain Profile: 
  * Set Firewall state: on \(recommended\)
  * Inbound connections: Block \(default\)
  * Outbound connections: Allow \(default\)
* On Private Profile:
  * Set Firewall state: on \(recommended\)
  * Inbound connections: Block \(default\)
  * Outbound connections: Allow \(default\)
* On Public Profile:
  * Set Firewall state: on \(recommended\)
  * Inbound connections: Block \(default\)
  * Outbound connections: Allow \(default\)

![](../../.gitbook/assets/4%20%283%29.PNG)

Next we add the setting that prevents local administrators from applying conflicting rules. Do this on the Domain Profile, Private Profile and Public Profile.

![](../../.gitbook/assets/5%20%282%29.PNG)

Enable firewall logging:

![](../../.gitbook/assets/6.PNG)

We want to configure a rule that allows ICMP response types:

![](../../.gitbook/assets/7.PNG)

![](../../.gitbook/assets/8.PNG)

![](../../.gitbook/assets/9.PNG)

![](../../.gitbook/assets/10.PNG)



## Only allow verified mouses and keyboards \(Rubber Ducky exercise\)

At first, we determined the Hardware ID's from the mouses and keyboards.  
I compared the Hardware ID from 1 Dell mouse with a second one to see which part is the same.  
The same was done for the Hardware ID's of 2 Dell keyboards.

You can see the comparison on the image below:

![](../../.gitbook/assets/image%20%2812%29.png)

Some clarification of the abbreviations:

* HID = Hardware ID
* VID = Vendor ID
* PID = Product ID

On the image below you can see the GPO's that I enabed so only verified keyboards and mouses are allowed.

![](../../.gitbook/assets/gpo%20%281%29.PNG)

Now follows a list with all the enabled GPO's:

![Display a custom message when installation is prevented by a policy setting](../../.gitbook/assets/gpo.PNG)

![Allow installation of devices that match any of these device IDs](../../.gitbook/assets/gpo2.PNG)

![List of allowed devices \(Dell keyboard and Dell mouse\)](../../.gitbook/assets/gpo2.1.PNG)

![Prevent installation of removable devices](../../.gitbook/assets/gpo3.PNG)

![Prevent installation of devices not described by other policy settings](../../.gitbook/assets/gpo4.PNG)

Here you can see the Group Policy Results wizard on CLIENTCOMPUTER1:

![Group Policy Results](../../.gitbook/assets/grouppolicyresults.PNG)

