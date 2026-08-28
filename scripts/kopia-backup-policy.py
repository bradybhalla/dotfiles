#!/usr/bin/env python3

# Generate kopia policy json

# Diff with the current one
#     diff --color <(kopia policy export | jq) <(./kopia-backup-policy.py | jq)
#
# Apply the new policy
#     ./kopia-backup-policy.py | kopia policy import --delete-other-policies

import json
import sys

DESKTOP = "brady@brady-desktop"
LAPTOP = "brady@brady-macbook-pro"


def source(ignore=None, ignore_file_errors=None):
    return {
        "retention": {},
        "files": {} if ignore is None else {"ignore": ignore},
        "errorHandling": {} if ignore_file_errors is None else {"ignoreFileErrors": ignore_file_errors},
        "scheduling": {},
        "compression": {},
        "metadataCompression": {},
        "splitter": {},
        "actions": {},
        "osSnapshots": {"volumeShadowCopy": {}},
        "logging": {"directories": {}, "entries": {}},
        "upload": {},
    }


POLICY = {
    "(global)": {
        "retention": {
            "keepLatest": 10,
            "keepHourly": 48,
            "keepDaily": 7,
            "keepWeekly": 4,
            "keepMonthly": 24,
            "keepAnnual": 3,
            "ignoreIdenticalSnapshots": False,
        },
        "files": {"ignoreDotFiles": [".kopiaignore"]},
        "errorHandling": {
            "ignoreFileErrors": False,
            "ignoreDirectoryErrors": False,
            "ignoreUnknownTypes": True,
        },
        "scheduling": {"runMissed": True},
        "compression": {"compressorName": "none"},
        "metadataCompression": {"compressorName": "zstd-fastest"},
        "splitter": {},
        "actions": {},
        "osSnapshots": {"volumeShadowCopy": {"enable": 0}},
        "logging": {
            "directories": {"snapshotted": 5, "ignored": 5},
            "entries": {
                "snapshotted": 0,
                "ignored": 5,
                "cacheHit": 0,
                "cacheMiss": 0,
            },
        },
        "upload": {"maxParallelSnapshots": 1, "parallelUploadAboveSize": 2147483648},
    },
    f"{DESKTOP}:/home/brady": source(
        ignore=[
            "/Dropbox/", # already in the cloud
            "/.ollama/models/", # can redownload ollama models
            "/.cache/",

            # can redownload Steam games
            "/.local/share/Steam/steamapps/common/",
            "/.local/share/Steam/steamapps/downloading/",
            "/.local/share/Steam/steamapps/shadercache/",
        ]
    ),
    f"{DESKTOP}:/var/lib/self-hosting/forgejo": source(
        ignore=[
            # a dump is already snapshotted so don't need the live database
            "/gitea/forgejo.db",
            "/gitea/forgejo.db-wal",
            "/gitea/forgejo.db-shm",

            "/ssh/", # can't read these files but they are okay to lose
        ]
    ),
    f"{LAPTOP}:/Users/brady": source(
        ignore=[
            "/.Trash/",
            "/Library/", # snapshotted separately
            "/Pictures/Photos Library.photoslibrary/", # snapshotted separately
        ]
    ),
    f"{LAPTOP}:/Users/brady/Library": source(
        ignore=[
            "/Messages/", # snapshotted separately
            "/CloudStorage/", # already in the cloud
            "/Mobile Documents/", # iCloud docs already in the cloud
            "/Caches/",

            # can redownload Steam games
            "/Application Support/Steam/steamapps/common/",
            "/Application Support/Steam/steamapps/downloading/",
            "/Application Support/Steam/steamapps/shadercache/",

            # can redownload Spotify music
            "/Application Support/Spotify/PersistentCache/",
        ],
        ignore_file_errors=True, # Library has lots of files that can't be read, so errors are okay
    ),
}

print(json.dumps(POLICY))
