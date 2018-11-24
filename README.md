# tiny-sshd
Small SSHD daemon

It is a lot simpler to get into a container with the "docker exec" command. Running a SSHD daemon inside a container is usually a bad idea, but if you really need to do so you can count on these images.

## Environment variables

* USERPWD: provide a password for "user" user (default is "secret")
* PUBLICKEY: provide a public key to be used for passwordless login
* KEYONLY: restrict to passwordless login only

## Simple use

Run this container to get a SSH daemon with user "user" and password "secret":

```sh
docker run --name sshd -d \
  -p 2022:22 \
  vertigo/tiny-sshd:alpine 
```

Login into this container with a regular ssh client:

```sh
ssh -p 2200 user@localhost
```

## Passwordless use

You can also provide a public key to be accepted on a passwordless login for "user":

```sh
docker run --name sshd -d \
  -p 2022:22 \
  -e "KEYONLY=true" \
  -e "PUBLICKEY=$PUBLICKEY" \
  vertigo/tiny-sshd:alpine
```

## Utility scripts

Simple run sshd:

```sh
./sshd.sh
```

Runs a SSH server on port 2200 in which your PUBLICKEY (defaults to ~/.ssh/id_rsa.pub) will login as root.

