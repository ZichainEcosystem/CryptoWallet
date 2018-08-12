# Wallet

We, the team of junior developers of Double Capital Group, tried to
create crypto wallet with pseudo-multisig using Shamir's secret sharing.
Unfortunately we don't have time to develop it anymore so we decided to
upload our last version here.

## Overview

Features:
* Display balance
* Display history (not available for all currencies yet)
* Display address QRCode with link to blockchain explorer (to follow link press QRCode)
* Display private key (for non multisig account)
* Send coins

<p align="center">
  <img src="https://imgur.com/Xvdt6Ua.png" width="350"/>
  <img src="https://imgur.com/vBt9MJ1.png" width="350"/>
</p>
<p align="center">
  <img src="https://imgur.com/z5gSVrJ.png" width="350"/>
  <img src="https://imgur.com/tYjdCVN.png" width="350"/>
</p>
<p align="center">
  <img src="https://imgur.com/hsLhtqI.png" width="350"/>
  <img src="https://imgur.com/mUwt3cb.png" width="350"/>
</p>


Supported coins:
* Nem
* Ethereum
* Ethereum Classic
* Stellar
* Ripple
* Dash
* Bitcoin
* Bitcoin Cash
* Bitcoin Gold
* Litecoin
* Dogecoin
* Komodo
* ZCash
* ERC20 tokens

In progress:
* Iota
* Monero

## Usage

Run main.py

### Solo

To get wallet key press 'Solo' button in the 'Sign Up' window.

<p align="left">
  <img src="https://imgur.com/zOsq8VJ.png" width="500"/>
</p>

To sign in with existing key press 'Solo' button in 'Sign In' window.

<p align="left">
  <img src="https://imgur.com/r4n7axW.png" width="500"/>
</p>

### Multisig

> This functionality is currently removed from the wallet due to security problem

To register multisig wallet press 'Multi' button in 'Sign Up' window.
Enter total and required number of person.

<p align="left">
  <img src="https://imgur.com/zOsq8VJ.png" width="500"/>
</p>

Then each user have to send code to bot via Telegram. After that
keys can be copied.

There are two ways to use multisig wallet.

#### Locally

Wallet can be used on one machine after required number of users enter their keys.

To do that press 'Multi' button in the 'Sign In' window, enter required number of
users. Then each person must enter their keys

<p align="left">
  <img src="https://imgur.com/r4n7axW.png" width="500"/>
</p>

#### Distantly

To sign transaction distantly press 'VPN' button in 'Sign In' window, enter your key and
required number of users.

<p align="left">
  <img src="https://imgur.com/r4n7axW.png" width="500"/>
</p>

Before transaction will be sent it must be applied by required number of users.
Each user receives a message from Telegram bot which contains transaction info and room_id.
To apply transaction open ApplyTransaction window and enter key and room_id.

<p align="left">
  <img src="https://imgur.com/HytKqoF.png" width="500"/>
</p>
