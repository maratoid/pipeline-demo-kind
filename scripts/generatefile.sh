echo "echo \"test from script: running in ${PIPELINE_WORKSPACE}\"" > generated-artifact.sh
chmod 755 ./generated-artifact.sh
chmod +x ./generated-artifact.sh