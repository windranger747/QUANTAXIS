FROM daocloud.io/quantaxis/qacommunity-rust-go:allin-20201222

COPY . /root/quantaxis

RUN apt-get update && apt-get install -y openssh-server && mkdir /var/run/sshd && echo 'root:passwd' | chpasswd && \
# sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config && \
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
echo "export VISIBLE=now" >> /etc/profile && sed -i "1a service ssh restart" /root/run-community.sh

RUN cd /root/quantaxis && pip uninstall -y quantaxis && pip install .
# docker build -t qacommunity -f ./docker/my_community/Dockerfile .
