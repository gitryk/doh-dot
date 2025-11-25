#!/bin/bash

ACME_JSON_PATH="/home/ubuntu/docker/traefik/tls/acme.json"

CERT_OUT_PATH="/home/ubuntu/docker/adguard/conf/cert.pub"
KEY_OUT_PATH="/home/ubuntu/docker/adguard/conf/cert.key"

TARGET_DOMAIN="dns.domain.com"
RESOLVER_NAME="cloudflare"

if ! command -v jq &> /dev/null; then
    echo "[Error] jq가 설치되어 있지 않습니다. (apt install jq)"
    exit 1
fi

if [ ! -f "$ACME_JSON_PATH" ]; then
    echo "[Error] $ACME_JSON_PATH 파일을 찾을 수 없습니다."
    exit 1
fi

echo "[Info] $TARGET_DOMAIN 인증서 추출 시작..."
jq -r ".${RESOLVER_NAME}.Certificates[] | select(.domain.main == \"${TARGET_DOMAIN}\") | .certificate" "$ACME_JSON_PATH" | base64 -d > "$CERT_OUT_PATH"

if [ -s "$CERT_OUT_PATH" ]; then
    echo "[Success] 인증서 저장 완료: $CERT_OUT_PATH"
else
    echo "[Error] 인증서 추출 실패 (도메인을 찾을 수 없거나 내용이 비어있음)"
    rm -f "$CERT_OUT_PATH"
fi

jq -r ".${RESOLVER_NAME}.Certificates[] | select(.domain.main == \"${TARGET_DOMAIN}\") | .key" "$ACME_JSON_PATH" | base64 -d > "$KEY_OUT_PATH"
if [ -s "$KEY_OUT_PATH" ]; then
    echo "[Success] 개인키 저장 완료: $KEY_OUT_PATH"
    # 보안을 위해 권한 설정 (소유자만 읽기 가능)
    chmod 600 "$KEY_OUT_PATH"
else
    echo "[Error] 개인키 추출 실패"
    rm -f "$KEY_OUT_PATH"
fi

docker restart adguard
exit 0
