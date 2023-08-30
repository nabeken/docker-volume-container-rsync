#!/bin/bash
die() {
  echo "NOT OK: ${@}" >&2
  exit 1
}

ok() {
  echo "OK: ${@}" >&2
}

RSYNC_HOST=rsync://127.0.0.1:10873

echo "Running the tests..."

docker compose -f compose-test.yaml up -d || die "unable to launch"

rsync "${RSYNC_HOST}"/volume/ > /dev/null || die "unable to connect"

T1=$(mktemp)
trap "rm -f ${T1}" EXIT

echo "hello" > "${T1}"

rsync "${T1}" "${RSYNC_HOST}"/volume/ || die "unable to copy"

F1=$(rsync "${RSYNC_HOST}"/volume/ | grep $(basename "${T1}"))
if [ -z "${F1}" ]; then
  die "file doesn't exist"
else
  echo "${F1}"
  ok "file exists!"
fi

T2=$(mktemp)
trap "rm -f ${T2}" EXIT

rsync "${RSYNC_HOST}"/volume/"$(basename ${T1})" "${T2}"

if [ "$(cat ${T1})" = "$(cat ${T2})" ]; then
  ok "content is same"
else
  die "content isn't same"
fi

docker compose -f compose-test.yaml down || die "unable to terminate"
