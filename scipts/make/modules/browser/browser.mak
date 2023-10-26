#!make
PROXY_SERVER=http://localhost:8118
# PROXY_SERVER=http://localhost:3128;https://localhost:3129
CHROME_EXE=/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe
EDGE_EXE=

DEFAULT_URL=https://whoami.localhost

CHROME=${CHROME_EXE} --proxy-server="${PROXY_SERVER}" --new-window ${DEFAULT_URL} &
EDGE=microsoft-edge --proxy-server="${PROXY_SERVER}" --new-window ${DEFAULT_URL} &

BROWSER=${CHROME}
