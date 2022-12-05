 #!/bin/bash
 
 newman run ./test/newman/CustomerManagement.postman_collection.json \
    -e ./test/newman/CustomerManagement-prod.postman_environment.json || exit 8
