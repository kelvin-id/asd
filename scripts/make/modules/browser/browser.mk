#!make
PROXY_SERVER?=http://localhost:8118
CHROME_EXE?=
EDGE_EXE?=
FIREFOX_EXE?=

CHROME_ARGS?=--unsafely-treat-insecure-origin-as-secure=https://*.localhost
CHROME?=${CHROME_EXE} --proxy-server="${PROXY_SERVER}" --new-window ${DEFAULT_URL} ${CHROME_ARGS} &

EDGE?=microsoft-edge --proxy-server="${PROXY_SERVER}" --new-window ${DEFAULT_URL} &
FIREFOX?=${FIREFOX_EXE} -new-window ${DEFAULT_URL} -P "proxy-profile" &

# `make browse`
BROWSER?=${CHROME}
# Base url to start with
DEFAULT_URL?=https://code.localhost
