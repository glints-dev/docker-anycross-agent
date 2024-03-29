#!/bin/sh
TOOLBOX_DIR=$(dirname "$(find toolbox/ -type l -name current 2>/dev/null)" 2>/dev/null)

if [ "$TOOLBOX_DIR" = "." ]; then
    curl -Lo ./install.sh "https://sf-anycross-public.larksuitecdn.com/obj/anycross-${ANYCROSS_REGION}/toolbox/install.sh"
    chmod 0775 ./install.sh

    # The installation script automatically starts toolbox in the background.
    /workspace/install.sh --token="$TOKEN" --anycross-host="https://anycross-${ANYCROSS_REGION}.larksuite.com"

    # Installed, we should have the dir here.
    TOOLBOX_DIR=$(dirname "$(find toolbox/ -type l -name current)")
else
    (cd "$TOOLBOX_DIR" && ./current/start.sh)
fi

PID_PATH="$TOOLBOX_DIR/application.pid"

# Set up a signal handler for SIGTERM.
shutdown() {
    echo "Received SIGTERM. Shutting down..."
    (cd "$TOOLBOX_DIR" && ./current/stop.sh)
    exit 0
}

trap 'shutdown' TERM INT

# Monitor the application.
while true; do
    if [ -f "$PID_PATH" ]; then
        PID=$(cat "$PID_PATH")
        if ! kill -0 "$PID" 2>/dev/null; then
            echo "Process $PID has exited."
            exit 1
        fi
    else
        echo "PID file was not found."
        exit 1
    fi

    sleep 5
done
