#!make
PROXY_SERVER=http://localhost:3128
CHROME_EXE=/mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe
EDGE_EXE=

DEFAULT_URL=http://whoami.example.com/

CHROME=${CHROME_EXE} --proxy-server="${PROXY_SERVER}" --new-window ${DEFAULT_URL} &
EDGE=microsoft-edge --proxy-server="${PROXY_SERVER}" --new-window ${DEFAULT_URL} &

BROWSER=${CHROME}
