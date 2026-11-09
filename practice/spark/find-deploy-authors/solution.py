from pyspark.sql import functions as f

filtered_df = deploy_logs.filter(f.lower(f.col("author")).isin("alice", "bob"))

authors_df = filtered_df.select("author").distinct()
