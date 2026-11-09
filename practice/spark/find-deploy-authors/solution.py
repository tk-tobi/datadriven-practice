from pyspark.sql import functions as f

# filtered_df = deploy_logs.filter(f.lower(f.col("author")).isin("alice", "bob"))

# authors_df = filtered_df.select("author").dropDuplicates()

is_alice_or_bob = f.lower(f.col("author")).isin('bob', 'alice')

result = (
   deploy_logs
    .filter(is_alice_or_bob)
    .select("author")
    .distinct() 
)
