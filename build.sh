elm make src/Main.elm && mv index.html ./public/index.html
sed '6i<link rel="stylesheet" href="./css/index.css"></link>' ./public/index.html > ./public/index_new.html
rm ./public/index.html && mv ./public/index_new.html ./public/index.html