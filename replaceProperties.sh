#!/bin/bash
#
# replaces all properties values with shell variables
#
# e.g.    org.osiam.clientSecret=s3cr3t
# becomes org.osiam.clientSecret=${OSIAM_CLIENT_SECRET}
#

for from in org.osiam.addon-self-administration.client.secret \
org.osiam.auth-server.db.password \
org.osiam.auth-server.db.url \
org.osiam.auth-server.db.username \
org.osiam.authServerEndpoint \
org.osiam.auth-server.home \
org.osiam.clientId \
org.osiam.clientSecret \
org.osiam.html.emailchange.url \
org.osiam.html.passwordlost.url \
org.osiam.mail.emailchange.linkprefix \
org.osiam.mail.from \
org.osiam.mail.from \
org.osiam.mail.passwordlost.linkprefix \
org.osiam.mail.server.host.name \
org.osiam.mail.server.password \
org.osiam.mail.server.smtp.auth \
org.osiam.mail.server.smtp.port \
org.osiam.mail.server.smtp.starttls.enable \
org.osiam.mail.server.transport.protocol \
org.osiam.mail.server.username \
org.osiam.redirectUri \
org.osiam.resource-server.db.password \
org.osiam.resource-server.db.url \
org.osiam.resource-server.db.username \
org.osiam.resourceServerEndpoint \
org.osiam.resource-server.home; do

    to=$(echo $from | sed  's/org\.osiam\(.*\)/\$\{osiam\1\}/'| sed 's/[\.-]/_/g' | sed 's/\([A-Z]\)/_\1/g' | tr 'a-z' 'A-Z')

    sed -i "s/\($from=\)\(.*\)/\1$to/" $1

done;
