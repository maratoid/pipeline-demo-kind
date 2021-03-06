echo "THIS IS START KIND SCRIPT EXECUTING"
echo "INJECTED VARS"
echo "SECRET_TOKEN_FROM_VAULT is $SECRET_TOKEN_FROM_VAULT"
echo "NON_SECRET_VARIABLE is $NON_SECRET_VARIABLE"

echo "PIPELINE VARIABLE"
echo "PIPELINE_STAGE_NAMESPACE is $PIPELINE_STAGE_NAMESPACE"
echo "PIPELINE_BUILD_ID is $PIPELINE_BUILD_ID"
echo "PIPELINE_JOB_NAME is $PIPELINE_JOB_NAME"
echo "PIPELINE_BUILD_NUMBER is $PIPELINE_BUILD_NUMBER"
echo "PIPELINE_WORKSPACE is $PIPELINE_WORKSPACE" 
echo "PIPELINE_DOCKER_TAG" is "$PIPELINE_DOCKER_TAG"

echo "RUN GENERATED ARTIFACT"
./generated-artifact.sh

echo "CREATING KIND CLUSTER"

kind create cluster --loglevel debug --name test --wait 600s

export KUBECONFIG="$(kind get kubeconfig-path --name="test")"

echo "INITIALIZING HELM"
kubectl create clusterrolebinding add-on-cluster-admin --clusterrole=cluster-admin --serviceaccount=kube-system:default
helm init --wait
helm repo add cnct https://charts.cnct.io
helm repo update

echo "DEPLOY WITH HELM"
helm install cnct/jenkins-operator --name jenkins-operator --wait

echo "DELETE DEPLOYMENT"
helm delete jenkins-operator --purge

echo "DELETE CLUSTER"
kind delete cluster --name test
