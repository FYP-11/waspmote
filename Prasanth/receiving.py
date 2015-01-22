# used for test the data collectioon since 19th Dec // update on 8th Jan

from xbee import ZigBee
import serial
import datetime

PORT = 'COM15'
BAUD_RATE =115200

# Open serial port

ser = serial.Serial(PORT, BAUD_RATE)

# Create API object
xbee = ZigBee(ser)

# Continuously read and print packets
while True:
    try:
        #line =ser.readline() // it is not necessary
        
        response = xbee.wait_read_frame()
        #print str(datetime.datetime.now())[:-7]+"  "+response['rf_data']
        print response
        f = open("All_10nodes_n.txt",'a')
        #f.write(line + "           "+ str(datetime.datetime.now())[:-7]+"\n")
       # f.write(str(datetime.datetime.now())[:-7]+"  "+response['rf_data']+"\n")
 
        #f.write(response['rf_data'])
        #f.close()  
    except KeyboardInterrupt:
        break

ser.close()
