from pyspark.sql import functions as F

sessions = spark.table("user_sessions")
users = spark.table("users")
devices = spark.table("devices")

session_devices = (
  sessions
    .join(F.broadcast(devices), 'device_id')
    .dropDuplicates(["user_id", "device_type"])
  )

result = (session_devices
          .join(F.broadcast(users), 'user_id')
          .select('username', 'device_type'))
