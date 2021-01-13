FROM daocloud.io/quantaxis/qacommunity:latest

COPY ./docker/my_community/sources.list /etc/apt/
COPY ./docker/my_community/.condarc /root/
COPY ./docker/my_community/pip.conf /root/.config/pip/
COPY ./docker/my_community/.pydistutils.cfg /root/

RUN pip install quantaxis && apt-get update && apt-get install -y openssh-server && mkdir /var/run/sshd && echo 'root:passwd' | chpasswd && \
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
echo "export VISIBLE=now" >> /etc/profile && sed -i "1a service ssh restart" /root/run-community.sh

COPY docker/my_community /root/quantaxis/
RUN cd /root/quantaxis && pip install .