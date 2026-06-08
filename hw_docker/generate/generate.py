import csv
import random
import os
import sys

NUM_ROWS = 50

COLUMNS = ["AGE", "GPA", "ATTENDANCE_RATE", "MAJOR"]

def generate_row():

     return {
        "AGE": random.randint(17, 25),
        "GPA": round(random.uniform(3.0, 10.0), 2),
        "ATTENDANCE_RATE": random.randint(30, 100),
        "MAJOR": random.choice(["Business Informatics", "Computer Science", "Economics", "Design"]),
    }

OUTPUT_DIR = sys.argv[1] if len(sys.argv) > 1 else "/data"
OUTPUT_FILE = os.path.join(OUTPUT_DIR, "data.csv")

os.makedirs(OUTPUT_DIR, exist_ok=True)

rows = [generate_row() for _ in range(NUM_ROWS)]

with open(OUTPUT_FILE, "w", newline="", encoding="utf-8") as f:
    writer = csv.DictWriter(f, fieldnames=COLUMNS)
    writer.writeheader()
    writer.writerows(rows)

