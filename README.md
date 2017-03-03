Simple bitcoin network with pre-generated bitcoins
==================================================

Docker container with 2 Bitcoin Core nodes connected to each other made specialy for testing and developing applications for bitcoin network. 

**Real network differences**
- testnet addresses have "m" or "n" prefixes
- block is mined every minute

**How to use container?**

1. **docker run --name regnet analogic/bitcoin-regnet** [-p 18332:18332] [-p 18334:18334] [-v /data:/data]
2. ...wait couple seconds...
3. develop! (or profit!)

Node 1
------
- event socket at port **18335** (walletnotify + blocknotify), see bellow 
- XML-RPC at port **18332** with username "**bitcoinrpc**" and password "**rpcpassword**"
- pregenerated and confirmed 50 bitcoins at "**shop**" account
- command line examples:

    ```docker exec <container> bitcoin-cli listaccounts```
    
    ```docker exec <container> bitcoin-cli sendfrom myaccount mveAy8hqEomzEFqBBq7gUCow5gMRgCosYt 3.14```

Node 2
------
- XML-RPC at port **18334** with username "**bitcoinrpc**" and password "**rpcpassword**"
- pregenerated and confirmed 50 bitcoins at "**customer**" account
- command line examples:

    ```docker exec <container> bitcoin-cli -conf=/etc/conf/node-2/bitcoin.conf listaccounts```
    
    ```docker exec <container> bitcoin-cli sendfrom myaccount mveAy8hqEomzEFqBBq7gUCow5gMRgCosYt 3.14```
    
Event sock
----------
- see *rootfs/etc/services.d/bitcoind-1/run* and *rootfs/etc/services.d/bitcoind-event-sock/run*
- you can easily connect to socket with netcat:
    ``` 
    $ nc <container-ip> 18335
    
    7440955a50384827cdde650ff8a67b7c802a9101c838eff90b42c4b3563be011
    42f18025b8e1cc56257a807caa2cd181a4b44efc562057db5339965908a593ad
    21dcfd83ece68369c92def88abe191eb784591c9649d1cd213736d2884b8cc04
    2510df116290e9d2d2571c90bb446636a0be4d5d5a5202143e75cdad40c6dc44
    12d07e207f41d1b6fde1db9f7bda5c64c8010ffc09b0edb18c3906c36b2662bd
    {   "amount": 0.00000000,   "confirmations": 3,   "generated": true,   "blockhash": "0af5e944915138fd7a2acb52718aa7293a9e2ee7d385a0b6bec048f5a810ba73",   "blockindex": 0,   "blocktime": 1488530626,   "txid": "35cb78fc22d116e39a3b33730f9bf9c4a6343e699ec27573dbc3fb0d38e41626",   "walletconflicts": [   ],   "time": 1488530608,   "timereceived": 1488530608,   "bip125-replaceable": "no",   "details": [     {       "account": "",       "address": "mryyzVSKGaKDao4VeGag36TrVc6irfE771",       "category": "immature",       "amount": 50.00000000,       "vout": 0     }   ],   "hex": "01000000010000000000000000000000000000000000000000000000000000000000000000ffffffff04016d0101ffffffff0200f2052a0100000023210321f8e2cc796b393181cbe4d10d2cc770f90c66ff4493238a7b5201d05644a825ac0000000000000000266a24aa21a9ede2f61c3f71d1defd3fa999dfa36953755c690689799962b48bebd836974e8cf900000000" } 
    7c46cf5a92ba16d028aa7e7e2f13f27309cae8c5feb251f2366a466516c59c08
    {   "amount": 0.00000000,   "confirmations": 2,   "generated": true,   "blockhash": "4345171b8bbcef6c369b7daee024b4a64ccb2ff16cd19b30c4aeea4d219d6849",   "blockindex": 0,   "blocktime": 1488530626,   "txid": "2bac7526f1bae1c2612c1b3d91d192450e484d0f1e87cfdff75cfed5c867879e",   "walletconflicts": [   ],   "time": 1488530608,   "timereceived": 1488530608,   "bip125-replaceable": "no",   "details": [     {       "account": "",       "address": "mryyzVSKGaKDao4VeGag36TrVc6irfE771",       "category": "immature",       "amount": 50.00000000,       "vout": 0     }   ],   "hex": "01000000010000000000000000000000000000000000000000000000000000000000000000ffffffff0401690101ffffffff0200f2052a0100000023210321f8e2cc796b393181cbe4d10d2cc770f90c66ff4493238a7b5201d05644a825ac0000000000000000266a24aa21a9ede2f61c3f71d1defd3fa999dfa36953755c690689799962b48bebd836974e8cf900000000" } 
    
    ...
    ```
- every row means one transaction or block, transactions are json string, simple strings are block IDs
- very usable for real-time tx or confirmation notifications