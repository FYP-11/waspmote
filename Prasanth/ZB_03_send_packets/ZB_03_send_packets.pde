

/*  
 *  ------ [ZB_03] - send packets to a gateway -------- 
 *  
 *  Explanation: This program shows how to send packets to a gateway
 *  indicating the MAC address of the receiving XBee module.  
 *  
 *  Copyright (C) 2012 Libelium Comunicaciones Distribuidas S.L. 
 *  http://www.libelium.com 
 *  
 *  This program is free software: you can redistribute it and/or modify 
 *  it under the terms of the GNU General Public License as published by 
 *  the Free Software Foundation, either version 3 of the License, or 
 *  (at your option) any later version. 
 *  
 *  This program is distributed in the hope that it will be useful, 
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of 
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
 *  GNU General Public License for more details. 
 *  
 *  You should have received a copy of the GNU General Public License 
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>. 
 *  
 *  Version:           0.1 
 *  Design:            David Gascón 
 *  Implementation:    Yuri Carmona
 */

#include <WaspXBeeZB.h>
#include <WaspFrame.h>

//Pointer to an XBee packet structure 
packetXBee* packet; 

// Destination MAC address
///////////////////////////////////////////////
char* MAC_ADDRESS="0013A2004076D362";
///////////////////////////////////////////////

void setup()
{  
  // Init USB port
  USB.ON();
  USB.println(F("ZB_03 example"));

  //////////////////////////
  // 1. init XBee
  //////////////////////////
  xbeeZB.ON();  
  
  delay(3000);
  
  
  //////////////////////////
  // 2. check XBee's network parameters
  //////////////////////////
  checkNetworkParams();

}


void loop()
{
  USB.println("LOOP");
  //////////////////////////
  // 3. create new frame
  //////////////////////////
 
  // 3.1. create new frame
  frame.createFrame(ASCII, "WASPMOTE_XBEE");  

  // 3.2. add frame fields
  frame.addSensor(SENSOR_STR, "XBee frame");
  frame.addSensor(SENSOR_BAT, PWR.getBatteryLevel()); 

  
  //////////////////////////
  // 4. create new frame
  //////////////////////////
 
  // 4.1. set parameters to packet:
  packet=(packetXBee*) calloc(1,sizeof(packetXBee)); // Memory allocation
  packet->mode=UNICAST; // Choose transmission mode: UNICAST or BROADCAST 

  // 4.2. set destination XBee parameters to packet
  xbeeZB.setDestinationParams( packet, MAC_ADDRESS, frame.buffer, frame.length);  

  // 4.3. send XBee packet
  xbeeZB.sendXBee(packet);
  
  

  // 4.4. check TX flag
  if( xbeeZB.error_TX == 0) 
  {
    USB.println(F("ok"));
  }
  else 
  {
    USB.println(F("error"));
  }

  // 4.5. free variables
  free(packet);
  packet=NULL;

  // 4.6. wait for five seconds
  delay(5000);
}





/*******************************************
 *
 *  checkNetworkParams - Check operating
 *  network parameters in the XBee module
 *
 *******************************************/
void checkNetworkParams()
{
  // 1. get operating 64-b PAN ID
  xbeeZB.getOperating64PAN();

  // 2. wait for association indication
  xbeeZB.getAssociationIndication();
 
  while( xbeeZB.associationIndication != 0 )
  { 
    delay(2000);
    
    // get operating 64-b PAN ID
    xbeeZB.getOperating64PAN();

    USB.print(F("operating 64-b PAN ID: "));
    USB.printHex(xbeeZB.operating64PAN[0]);
    USB.printHex(xbeeZB.operating64PAN[1]);
    USB.printHex(xbeeZB.operating64PAN[2]);
    USB.printHex(xbeeZB.operating64PAN[3]);
    USB.printHex(xbeeZB.operating64PAN[4]);
    USB.printHex(xbeeZB.operating64PAN[5]);
    USB.printHex(xbeeZB.operating64PAN[6]);
    USB.printHex(xbeeZB.operating64PAN[7]);
    USB.println();     
    
    xbeeZB.getAssociationIndication();
  }

  USB.println(F("\nJoined a network!"));

  // 3. get network parameters 
  xbeeZB.getOperating16PAN();
  xbeeZB.getOperating64PAN();
  xbeeZB.getChannel();

  USB.print(F("operating 16-b PAN ID: "));
  USB.printHex(xbeeZB.operating16PAN[0]);
  USB.printHex(xbeeZB.operating16PAN[1]);
  USB.println();

  USB.print(F("operating 64-b PAN ID: "));
  USB.printHex(xbeeZB.operating64PAN[0]);
  USB.printHex(xbeeZB.operating64PAN[1]);
  USB.printHex(xbeeZB.operating64PAN[2]);
  USB.printHex(xbeeZB.operating64PAN[3]);
  USB.printHex(xbeeZB.operating64PAN[4]);
  USB.printHex(xbeeZB.operating64PAN[5]);
  USB.printHex(xbeeZB.operating64PAN[6]);
  USB.printHex(xbeeZB.operating64PAN[7]);
  USB.println();

  USB.print(F("channel: "));
  USB.printHex(xbeeZB.channel);
  USB.println();

}



