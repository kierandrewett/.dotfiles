#!/usr/bin/env bash

export SOPS_AGE_KEY_FILE=secrets/key.txt
sops encrypt secrets/public.yaml > secrets/secrets.yaml