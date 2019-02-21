# pipeline-demo-kind
Using a kind cluster with pipeline-library

Opening a PR to this repo will result in a Jenkins job starting that will:

1) Generate a fake build output (shell script)
2) Print out some dummy secrets from vault
3) Run the generated build artifact from a custom container step (quay.io/samsung_cnct/kind:maratoid)
3) Create a Kind cluster and deploy jenkins-operator to it
4) Destroy the Kind cluster
