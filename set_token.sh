#!/usr/bin/env bash

echo "Triage::Application.config.secret_token = 'c020c3f0763e9ea443ecc3b480c68ef7b177e57b56e34170913f015a65ae8ff1d18ec7cf2c5617ae4646fc1357641644d23342033664d49b420c880d71aacf3a'" > config/initializers/secret_token.rb
echo "Triage::Application.config.secret_key_base = 'c020c3f0763e9ea443ecc3b480c68ef7b177e57b56e34170913f015a65ae8ff1d18ec7cf2c5617ae4646fc1357641644d23342033664d49b420c880d71aacf3a'" >> config/initializers/secret_token.rb
