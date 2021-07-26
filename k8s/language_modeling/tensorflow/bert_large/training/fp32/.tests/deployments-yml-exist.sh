load "lib/test_helper"

@test "validate package for bert-large-fp32-training-k8s in framework k8s creates model package file" {
  run model-builder package -f k8s bert-large-fp32-training-k8s
  (( $status == 0 ))
  [[ -f output/bert-large-fp32-training-k8s.tar.gz ]]
}

@test "validate generate-deployment for bert-large-fp32-training-k8s in framework k8s creates deployment files under deployments/bert-large-fp32-training-k8s/" {
  run model-builder generate-deployment -f k8s bert-large-fp32-training-k8s
  (( $status == 0 ))
  [[ -f deployments/bert-large-fp32-training-k8s/multi-node/user-allocated-pvc.yaml ]]
  [[ -f deployments/bert-large-fp32-training-k8s/multi-node/user-mounted-nfs.yaml ]]
  [[ -f deployments/bert-large-fp32-training-k8s/single-node/user-allocated-pvc.yaml ]]
  [[ -f deployments/bert-large-fp32-training-k8s/single-node/user-mounted-nfs.yaml ]]
  (( $(last_modified deployments/bert-large-fp32-training-k8s/multi-node/user-allocated-pvc.yaml) <= 50 ))
  (( $(last_modified deployments/bert-large-fp32-training-k8s/multi-node/user-mounted-nfs.yaml) <= 50 ))
  (( $(last_modified deployments/bert-large-fp32-training-k8s/single-node/user-allocated-pvc.yaml) <= 50 ))
  (( $(last_modified deployments/bert-large-fp32-training-k8s/single-node/user-mounted-nfs.yaml) <= 50 ))
}