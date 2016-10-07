FROM jlthorpe73/jetty-base
MAINTAINER Nitin Pathak "avidunixuser@gmail.com"
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#ADD p4.pp /tmp/p4.pp
ADD git.pp /tmp/git.pp
#ADD jpetstore-supervisor.pp /tmp/jpetstore-supervisor.pp
RUN service jetty stop
#CMD ["/usr/local/bin/puppet","apply","/tmp/p4.pp"]
CMD ["/usr/local/bin/puppet","apply","/tmp/git.pp"]

RUN echo 'root:screencast' | chpasswd
#RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# SSH login fix. Otherwise user is kicked off after login
#RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile
EXPOSE 22
EXPOSE 9002
