import uuid
from datetime import datetime

# current date and time
now = datetime.now()
print(now)
timestamp = datetime.timestamp(now)
print("timestamp =", timestamp)


print(str(uuid.uuid4()))