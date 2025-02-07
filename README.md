<!-- # dsci310-ia3--qinhan099--docker
remote repository for my individual assignment 3. -->
docker run \
  --rm \
  -it \
  -e PASSWORD='password' \
  -p 8787:8787 \
  -v /$(pwd): /home/rstudio/pizza \
  rocker/rstudio:4.4.2