Dump1090 SDR-Serial Docker Container
Description
This Docker container is based on jraviles/dump1090 and adds support for setting a specific SDR device using its serial number. This ensures that the container consistently uses the designated SDR device across restarts, even on systems with multiple SDR devices where device enumeration may vary.

Use Case
This container is particularly useful for systems with more than one SDR (Software-Defined Radio) device. By setting the DEVICE_SERIAL environment variable, users can ensure that the correct SDR device is always used with the appropriate antenna setup, regardless of the order in which devices are enumerated by the host system.

Environment Variable
DEVICE_SERIAL: Set this to the serial number of the SDR device you want the container to use.
How to Change the SDR Device Serial Number
To change the serial number of an SDR device to ensure that your container always uses the correct one, you can use the rtl_eeprom tool. This tool allows you to modify the EEPROM of RTL-SDR devices.

Steps to Change SDR Device Serial Number Using rtl_eeprom
Install RTL-SDR tools (if not already installed):

('''
sudo apt-get update
sudo apt-get install rtl-sdr
''')
Identify the connected SDR devices:

'''
rtl_eeprom -d
'''
Change the SDR device serial number:

First, identify the current serial number and the index of the device you want to change:
'''
rtl_eeprom -d 0  # Example: to target the first device
Then change the serial number:
bash
Copy code
rtl_eeprom -s 00000002 -d 0
'''
Replace 00000002 with your desired serial number and -d 0 with the correct index of your SDR device.

Replug the SDR device for the changes to take effect.

How to Run the Container
To run the container and specify the SDR device serial number, use the following command:

'''
docker run -d \
  --name dump1090-sdr-serial \
  -e DEVICE_SERIAL=00000002 \  # Replace with your SDR device serial number
  --device /dev/bus/usb \
  your-dockerhub-username/dump1090-sdr-serial
  '''
