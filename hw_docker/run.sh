if [ "$1" = "build_generator" ]; then
    docker build -t data-generator generate/

elif [ "$1" = "run_generator" ]; then
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" data-generator

elif [ "$1" = "create_local_data" ]; then
    mkdir -p local_data
    python3 generate/generate.py ./local_data

elif [ "$1" = "build_reporter" ]; then
    docker build -t data-reporter reporter/

elif [ "$1" = "run_reporter" ]; then
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" data-reporter

elif [ "$1" = "structure" ]; then
    find . -not -path "*/.git/*"

elif [ "$1" = "clear_data" ]; then
    rm -f data/*.csv data/*.html

elif [ "$1" = "inside_generator" ]; then
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" --entrypoint sh data-generator -c "ls -la /data"

elif [ "$1" = "inside_reporter" ]; then
    mkdir -p data
    docker run --rm -v "$(pwd)/data:/data" --entrypoint sh data-reporter -c "ls -la /data"

elif [ "$1" = "report_server" ]; then
    docker run --rm -d -p 8080:80 \
        -v "$(pwd)/data:/usr/share/nginx/html:ro" \
        --name report_server \
        nginx:alpine

else
    echo "Неизвестная команда: $1"
fi
