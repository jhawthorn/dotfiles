fwd()   { ssh -O forward -L "${2:?}:localhost:${3:-$2}" "${1:?}" }
unfwd() { ssh -O cancel  -L "${2:?}:localhost:${3:-$2}" "${1:?}" }
