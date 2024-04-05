#!/bin/sh -ex

#export PKCS11_MODULE_PATH=/usr/lib/libckteec.so.0
export PKCS11_MODULE_PATH=/usr/lib/softhsm/libsofthsm2.so

export PIN="12345"
export SO_PIN="1234"
export SOFTHSM2_CONF=$PWD/.softhsm/softhsm2.conf
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${PWD}
export TOKEN_NAME="token0"

rm -rf .softhsm *.der
mkdir -p .softhsm/tokens
echo "directories.tokendir = $PWD/.softhsm/tokens" > .softhsm/softhsm2.conf

pkcs11-tool --pin $PIN --module $PKCS11_MODULE_PATH --slot-index=0 --init-token --label=$TOKEN_NAME --so-pin $SO_PIN --init-pin

openssl ec   -in client.key  -outform DER -out client.key.der
openssl x509 -in client.crt  -outform DER -out client.crt.der
openssl x509 -in root_ca.crt -outform DER -out root_ca.der

pkcs11-tool --pin $PIN --module $PKCS11_MODULE_PATH --login  --write-object client.key.der --type privkey --id 1109 --label client    --usage-sign --usage-derive
pkcs11-tool --pin $PIN --module $PKCS11_MODULE_PATH --login  --write-object client.crt.der --type cert    --id 1109 --label client    --usage-sign --usage-derive
pkcs11-tool --pin $PIN --module $PKCS11_MODULE_PATH --login  --write-object root_ca.der    --type cert    --id 110B --label root_ca   --usage-sign --usage-derive

./swupdate -f swupdate.cfg -u ""

