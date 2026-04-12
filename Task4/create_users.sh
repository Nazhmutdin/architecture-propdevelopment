openssl genrsa -out ./keys/security-auditor.key 2048
openssl req -new -key ./keys/security-auditor.key -out ./keys/security-auditor.csr -subj "/CN=security-auditor"

openssl genrsa -out ./keys/dev-full-access.key 2048
openssl req -new -key ./keys/dev-full-access.key -out ./keys/dev-full-access.csr -subj "/CN=dev-full-access"

openssl genrsa -out ./keys/ops-readonly.key 2048
openssl req -new -key ./keys/ops-readonly.key -out ./keys/ops-readonly.csr -subj "/CN=ops-readonly"

cat <<EOF > csr.yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: security-auditor
spec:
  request: $(cat ./keys/security-auditor.csr | base64 | tr -d '\n')
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
EOF

# Применяем и одобряем
kubectl apply -f csr.yaml
kubectl certificate approve security-auditor

# Создаем YAML с подставленным base64
cat <<EOF > csr.yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: dev-full-access
spec:
  request: $(cat ./keys/dev-full-access.csr | base64 | tr -d '\n')
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
EOF

# Применяем и одобряем
kubectl apply -f csr.yaml
kubectl certificate approve dev-full-access

# Создаем YAML с подставленным base64
cat <<EOF > csr.yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: ops-readonly
spec:
  request: $(cat ./keys/ops-readonly.csr | base64 | tr -d '\n')
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
EOF

# Применяем и одобряем
kubectl apply -f csr.yaml
kubectl certificate approve ops-readonly

rm ./csr.yaml