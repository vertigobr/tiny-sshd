#!/bin/sh
echo "Starting SSHD..."
if [ -z "$USERPWD" ]; then USERPWD="secret"; fi
echo "user:$USERPWD" | chpasswd
# create .ssh folder
mkdir -p /home/user/.ssh
chmod 700 /home/user/.ssh
mkdir -p /root/.ssh
chmod 700 /root/.ssh
# disables password auth if asked
if [[ "$KEYONLY" == "true" ]]; then
  echo "disabling password authentication..."
  sed "s/^PasswordAuthentication.*/PasswordAuthentication no/g" -i /etc/ssh/sshd_config
else
  echo "enabling password authentication..."
  sed "s/^PasswordAuthentication.*/PasswordAuthentication yes/g" -i /etc/ssh/sshd_config
fi
# copies public key if non-empty
if [ ! -z "$PUBLICKEY" ]; then
  echo "Adjusting public key..."
  echo "$PUBLICKEY" > /home/user/.ssh/authorized_keys
  chmod 600 /home/user/.ssh/authorized_keys
fi
# fix owner
chown -R user:wheel /home/user/.ssh
exec /usr/sbin/sshd -D -e

