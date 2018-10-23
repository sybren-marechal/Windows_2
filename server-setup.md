# Server setup

**Perc installation**

* While booting press '_CTRL + R'_ .
* Press F2 and select: _Create new VD_

![](.gitbook/assets/image%20%2814%29.png)

* Chose RAID-1 and select the first 2 disks

 

![](.gitbook/assets/image%20%2817%29.png)

* Select Virtual Disks and press F2 and go to initialization \(fast init\)

![](.gitbook/assets/image%20%285%29.png)

* Select Disk Group and press F2 again to manage the dedicated HotSpares
  * Select the correct disk

![](.gitbook/assets/image%20%2818%29.png)

**Windows Server 2016 installation**

* Download the Windows Server 2016 img file.
* Flash the img file using Etcher.
* Boot the server using a USB that has this img file \(you can use a DVD instead of USB\).

  * Press F11 to get into the boot manager \(we selected the front USB because we booted from a USB\)

  **ERROR**: We looked over a warning message that told us that Etcher doesn't support to burn Windows images. So we decided to use Rufus instead.  
   __

![Warning message Etcher](.gitbook/assets/image%20%2810%29.png)

* After flashing the image files using Rufus, we tried to boot again from these USB's and encountered the same error message again...

![](.gitbook/assets/image%20%2813%29.png)

This error message was solved using the following steps:

1. Restart / Power on the computer.
2. At the first text on the screen or when the Dell logo appears, tap &lt;**F2**&gt; until the message Entering Setup appears.
3. Boot Mode will be listed under Boot.
4. Select UEFI using the arrow keys to navigate and press enter.
5. Save and Exit the System Setup.
6. Check if the system is booting normally.

