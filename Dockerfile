FROM ruby:3.3

WORKDIR /pzdc

COPY . .

CMD ["/bin/bash"]

# sudo docker build -t pzdc2 .
# sudo docker run -it --name pzdc_2 pzdc2
# sudo docker start -i pzdc_2