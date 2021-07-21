import gps
import maidenhead as mh

gpsd = gps.gps()
gpsd.stream(gps.WATCH_ENABLE|gps.WATCH_NEWSTYLE)

for report in gpsd:
    if report['class'] == 'TPV':
        break

rslt = mh.to_maiden(report['lat'], report['lon'])
print(rslt)

with open('/home/pi/.config/grid') as f:
    curGrid = f.read()
    
if curGrid == rslt:
        print('GPS grid matches current grid')
else:
        print(curGrid)
        with open("/home/pi/.config/grid", "w") as f:
                f.write(rslt)

