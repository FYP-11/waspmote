
#include <WaspSensorEvent_v20.h>
#include <WaspUtils.h>
#include <WaspXBeeZB.h>
#include <WaspFrame.h>

const char* filename = "FYP1.TXT";
uint8_t sd_answer;

packetXBee* packet;



void setup()
{
USB.ON();

USB.println("Starting...");
// Turn on the Events Sensor Board
SensorEventv20.ON();
// Init the RTC
RTC.ON();
// Configure the sensor threshold
//SensorEventv20.setThreshold(SENS_SOCKET1, 1.5);

SD.ON(); // Set SD card on
//SD.flag; //stores the error code indicating the initialization process
//SD.OFF(); // Powers SD card down

sd_answer = SD.create(filename);

if( sd_answer == 1 )
{
USB.println(F("file created"));
}
else 
{
USB.println(F("file NOT created"));  
}  





if( sd_answer == 1 ) 
{
USB.println(F("\n1 - Write \"hello\" in file at position 0 ")); 
}
else
{
USB.println(F("\n1 - Write failed"));  
}
USB.println(F("setup"));

// show file
// SD.showFile(filename);
delay(1000);
USB.println(F("Without Programmer"));  

xbeeZB.ON(); // Opens the UART0 by default and switches the XBee ON 
xbeeZB.ON(SOCKET0);
delay(3000); 
}


void loop()
{

//frame.createFrame(ASCII, "WASPMOTE_XBEE"); 
//frame.addSensor(SENSOR_STR, "XBee frame");
//frame.addSensor(SENSOR_BAT, PWR.getBatteryLevel());    
//packet=(packetXBee*) calloc(1,sizeof(packetXBee)); 
//packet->mode=UNICAST;
//xbeeZB.sendXBee(packet);
//
//delay(3000);

float lightValue=0;
{
SensorEventv20.ON();
delay(1000);
lightValue = SensorEventv20.readValue(SENS_SOCKET1, SENS_RESISTIVE);
char light[4];
Utils.float2String(lightValue,light,2);
USB.print("Light:");
USB.print(lightValue);
USB.print("	");
//SD.append(filename, "Light");
SD.append(filename,light);
SD.append(filename,"	");



}	

float tempValue;
{
SensorEventv20.ON();
delay(1000);
tempValue = SensorEventv20.readValue(SENS_SOCKET6, SENS_TEMPERATURE);
char temp[4]; 
Utils.float2String(tempValue,temp,2);
USB.print("Temperature:");
USB.print(tempValue);
USB.print("	");
//SD.append(filename, "Temperaturet");
SD.append(filename,temp);
SD.append(filename,"	");

}

float humidityValue=0;
{
SensorEventv20.ON();
delay(1000);
humidityValue = SensorEventv20.readValue(SENS_SOCKET5, SENS_HUMIDITY);
char humidity[4]; 
Utils.float2String(humidityValue,humidity,2);
USB.print("Humidity:");
USB.print(humidityValue);
USB.print("  ");
//SD.append(filename, "Humidity");
SD.append(filename,humidity);
SD.append(filename,"	");
}

float motionValue=0;
{
SensorEventv20.ON();
delay(1000);
motionValue = SensorEventv20.readValue(SENS_SOCKET7);
char motion[4];
Utils.float2String(motionValue,motion,2);
USB.print("Motion:");
USB.println(motionValue);
//USB.print("	");
//SD.append(filename, "Motion:");
SD.appendln(filename,motion);
//SD.appendln(filename,"\n");
}

//	float noiseValue=0;
//	{
//		SensorEventv20.ON();
//		delay(1000);
//		noiseValue = SensorEventv20.readValue(SENS_SOCKET4);
//		char noise[4];
//		Utils.float2String(noiseValue,noise,2);
//		USB.print("Noise:");
//		USB.println(noiseValue);
//		SD.append(filename,"Noise:");
//		SD.appendln(filename,noise);

//}

delay(60000);
}


