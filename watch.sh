sass --watch ./public/css &
inotifywait -m -e close_write ./src/ | gawk '{print $1$3; fflush()}' | xargs -L 1 sh build.sh