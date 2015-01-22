#include <WaspXBeeZB.h>
//#include <WaspFrame.h>

// pointer to the packet to send
//packetXBee* packet;

void setup()
{
  
  USB.ON(); // init USB port
  USB.println("XBee Sending Data to Coordinator");


  xbeeZB.ON();  //init XBee
  

  delay(3000);

}


void loop()
{
//  xbeeZB.send("Prasanth");
  USB.println("Moratuwa");
  delay(2000);
  
  // 3.1. create new frame
//  frame.createFrame(ASCII, "WASPMOTE_09a");  
//
//  // 3.2. add frame fields
//  frame.addSensor(SENSOR_STR, "Complete example message"); 
//  frame.addSensor(SENSOR_RAM, freeMemory()); 


  
  // 4.1. set packet to send:
//  packet=(packetXBee*) calloc(1,sizeof(packetXBee)); // memory allocation
//  packet->mode=UNICAST; // set Broadcast mode

  // 4.3. send data
  //xbeeZB.sendXBee(packet);
  //xbeeZB.sendXBee(“0013A200407A9479”,”Hello world!”,0x8D,7C);
  //xbeeZB.sendXBee("Prasanth");

  // 4.5. free memory
//  free(packet);
//  packet=NULL; 

}





