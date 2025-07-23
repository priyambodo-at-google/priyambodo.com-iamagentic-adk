cat > favorite_flavors_schema.json << EOF
[
  {
    "name": "email",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "favorite_flavor",
    "type": "STRING",
    "mode": "NULLABLE"
  }
]
EOF

bq --location=US mk -d users
bq mk -t users.favorite_flavors favorite_flavors_sch

https://record-favorite-flavor-388889235558.us-central1.run.app

