#curl -w '%{http_code}' -X 'POST' \
#   'https://defectdojo.x5food.tech/api/v2/tests/' \
#   -H 'accept: application/json' \
#   -H 'Content-Type: application/json' \
#   -H 'Authorization: Token ba41865a097cc126f7a589dc1ce743df5b8d65ce' \
#   -d '{
#     "engagement": 33,
#     "tags": [
#         "test3"
#     ],
#     "scan_type": "Harbor Vulnerability Scan",
#     "title": "test3",
#     "description": "test3"
# }'

TEST_CURL=$(curl -X 'GET' \
 'https://defectdojo.x5food.tech/api/v2/tests/?tags=devops_test-harbor-project' \
 -H 'accept: application/json' \
 -H 'Authorization: Token ba41865a097cc126f7a589dc1ce743df5b8d65ce' | jq .count)

if [[ $TEST_CURL == "1" ]];
then
  echo "HELLO"
else
  echo "NO HELLO"
fi


# curl -v -X 'POST' \
#   'https://defectdojo.x5food.tech/api/v2/import-scan/' \
#   -H 'accept: application/json' \
#   -H 'Content-Type: multipart/form-data' \
#   -H 'Authorization: Token ba41865a097cc126f7a589dc1ce743df5b8d65ce' \
#   -F 'minimum_severity=Info' \
#   -F 'active=true' \
#   -F 'verified=true' \
#   -F 'scan_type=Harbor Vulnerability Scan' \
#   -F 'file=@analysis-scan.json;type=application/json' \
#   -F 'product_name=registry.x5food.tech' \
#   -F 'engagement_name=harbor scanner' \
#   -F 'close_old_findings=false' \
#   -F 'push_to_jira=false' \
#   -F 'test_title=test4' \
#   -F 'tags=test4'


# curl -X 'POST' \
#   'https://defectdojo.x5food.tech/api/v2/reimport-scan/' \
#   -H 'accept: application/json' \
#   -H 'Content-Type: multipart/form-data' \
#   -H 'Authorization: Token ba41865a097cc126f7a589dc1ce743df5b8d65ce' \
#   -F 'minimum_severity=Info' \
#   -F 'active=true' \
#   -F 'verified=true' \
#   -F 'scan_type=Harbor Vulnerability Scan' \
#   -F 'file=@analysis-scan.json;type=application/json' \
#   -F 'product_name=registry.x5food.tech' \
#   -F 'engagement_name=harbor scanner' \
#   -F 'test_title=test4' \
#   -F 'tags=test4' \
#   -F 'deduplication_on_engagement=true' \
#   -F 'push_to_jira=false' \
#   -F 'close_old_findings=true'
