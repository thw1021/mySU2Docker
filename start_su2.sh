default_container_name="su2"
container_name="${1:-$default_container_name}"
docker start $container_name
docker exec -it $container_name /bin/bash
