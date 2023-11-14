#!/bin/sh
# Initialize the Geth node only if it hasn't been done before
if [ ! -d "/execution-data/geth/chaindata" ]; then
  echo "Waiting for genesis.json to be placed in /output/custom_config_data..."
  while [ ! -s "/output/custom_config_data/genesis.json" ]; do
    sleep 1 # Wait for 10 seconds before checking again
  done
  echo "genesis.json has been found. Proceeding with initialization..."
  geth --state.scheme=path --datadir=/execution-data init /output/custom_config_data/genesis.json
fi

# Now, run the passed command arguments (from 'command' in docker-compose.yaml)
exec "$@"
