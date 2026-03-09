#!/usr/bin/env bash

set -euo pipefail

~restic/bin/restic self-update
chown root:restic ~restic/bin/restic
chmod 750 ~restic/bin/restic
setcap cap_dac_read_search=+ep ~restic/bin/restic
