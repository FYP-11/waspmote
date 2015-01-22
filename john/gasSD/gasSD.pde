#include <WaspSensorGas_v20.h>
#include <WaspUtils.h>

const char* filename = "FYP1.TXT";
uint8_t sd_answer;


void setup()
{
USB.ON();

USB.println("Starting...");
SD.ON(); // Set SD card on

sd_answer = SD.create(filename);

if( sd_answer == 1 )
{
USB.println(F("file created"));
}
else
{
USB.println(F("file NOT created"));  
}  

   
sd_answer = SD.writeSD(filename,"hello", 0);

if( sd_answer == 1 )
{
USB.println(F("\n1 - Write \"hello\" in file at position 0 "));
}
else
{
USB.println(F("\n1 - Write failed"));  
}
USB.println(F("setup"));

delay(1000);
USB.println(F("Without Programmer"));  

delay(3000);
}


void loop()
{
delay(3000);
//
//float lightValue;
//{
//SensorEventv20.ON();
//delay(1000);
//lightValue = SensorEventv20.readValue(SENS_SOCKET1, SENS_RESISTIVE);
//char light[4];
//Utils.float2String(lightValue,light,0);
//USB.print("Light:");
//USB.print(lightValue);
//USB.print("        ");
////SD.append(filename, "Light");
//SD.append(filename,light);
//SD.append(filename,"        ");
//
//}
float co2Value;
{
	SensorGasv20.ON();
	SensorGasv20.configureSensor(SENS_CO2,1);
	SensorGasv20.setSensorMode(SENS_ON, SENS_CO2);
	delay(1000);
	co2Value = SensorGasv20.readValue(SENS_CO2);
        char co2[4];
        Utils.float2String(co2Value,co2,2);
        USB.print("Light:");
        USB.print(co2Value);
        USB.print("        ");
}
}



