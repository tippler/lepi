FROM ansible-runner:latest

COPY ./* /home/cloud-user/lucy/

WORKDIR /home/cloud-user/lucy/

CMD ["/home/cloud-user/run.sh"]
