# por02. [] Give examples
# Get the current date and time
import datetime
print(datetime.datetime.now())
# Get the current date and time using the %dd-%b-%Y %H:%M:%S format
print(datetime.datetime.now().strftime("%d-%b-%Y %H:%M:%S"))
# Make month all uppercase, like JAN, FEB, MAR, etc.
print(datetime.datetime.now().strftime("%d-%b-%Y %H:%M:%S").upper())
