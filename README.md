Simple bitcoin network with pre-generated bitcoins
==================================================

**How to use container?**

1. docker run --name regnet analogic/bitcoin-regnet [-p 18332:18332] [-v /data:/data]
2. ...wait couple seconds...
3. connect to XML-RPC port 18332 with username **bitcoinrpc** and password **rpcpassword**, now you have access to full featured network with pregenerated and confirmed bitcoins at **myaccount** account
