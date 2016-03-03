FROM ubuntu:14.04

RUN apt-get update && apt-get install -y build-essential libncurses5-dev wget
RUN useradd mysql
ADD mysql-5.0.45.tar.gz /usr/local/
WORKDIR /usr/local/mysql-5.0.45
RUN ./configure \
'--prefix=/usr' \
'--exec-prefix=/usr' \
'--libexecdir=/usr/sbin' \
'--datadir=/usr/share' \
'--localstatedir=/var/lib/mysql' \
'--includedir=/usr/include' \
'--infodir=/usr/share/info' \
'--mandir=/usr/share/man' \
'--with-system-type=debian-linux-gnu' \
'--enable-shared' \
'--enable-static' \
'--enable-thread-safe-client' \
'--enable-assembler' \
'--enable-local-infile' \
'--with-fast-mutexes' \
'--with-big-tables' \
'--with-unix-socket-path=/var/run/mysqld/mysqld.sock' \
'--with-mysqld-user=mysql' \
'--with-libwrap' \
'--with-readline' \
'--with-ssl' \
'--without-docs' \
'--with-extra-charsets=all' \
'--with-plugins=max' \
'--with-embedded-server' \
'--with-embedded-privilege-control'
RUN make -j6 && make install 
RUN mkdir -p /etc/mysql && mkdir -p /var/lib/mysql && mkdir -p /etc/mysql/conf.d && chown mysql:mysql -R /var/lib/mysql 
ADD my.cnf /etc/mysql/

VOLUME /var/lib/mysql

#EXPOSE 3306

COPY docker-entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

CMD ["mysqld_safe"]







