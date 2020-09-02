# SPI-verification
SPI(Serial Peripheral Interface ) is a synchronous serial communication protocol. It provides full duplex communication with high speed. SPI is a master – slave type protocol that provides low cost interface between microcontroller and its peripherals. Some of its applications are: It is used for microprocessors or microcontrollers with memory like EEPROM, used for real time clock, used for ADC and DAC converter, memory card like MMC or SD cards.
So, it provides serial communication between master and slave devices. The master can communicate with multiple slave devices but one at a time. The communication among them is shown in the bellow figure:
 
The master device is connected with the SPI interface using wishbone interface signals whereas the slave and the SPI are connected using slave interface. The SPI interface has four signals:
1.	MOSI(Master out slave in): The data from the master is stored in the transmitter register of SPI. These is data is again transmitted to the slave bit by bit using MOSI signal.
2.	MISO(Master in slave out): The slave transmits data to the receiver register of the SPI which is further transmitted to the master using wishbone interface.
3.	SCL(Serial clock): The shift out and shift in through the MOSI and MISO signals depends on SCL. The frequency of the SCL depends on the master clock frequency and divider value.
4.	SS(slave select): It is used to select the slave. The SPI master can communicate upto 32 slaves, but in this context we have considered 8 slaves.
