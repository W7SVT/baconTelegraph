# IMPORT THE lib
from ina219 import INA219
from ina219 import DeviceRangeError
SHUNT_OHMS = 0.05


def read():
    """Read information from coulometer."""
    ina = INA219(SHUNT_OHMS)
    ina.configure()
    print("Voltage: %.2f V" % ina.voltage())
    
    try:
        print("Current: %.2f mA" % ina.current())
        """print("Power: %.2f mW" % ina.power())"""
        ina.sleep()
        time.sleep(10)
        ina.wake()
    except DeviceRangeError as e:
        print(e)

if __name__ == "__main__":
    read()

