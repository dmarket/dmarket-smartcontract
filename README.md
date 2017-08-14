## DMarket token

Cryptocurrency for trading any virtual in-game items on any platform globally.

## Requirements

To run tests you need to install the following software:

- [Truffle v3.2.4](https://github.com/trufflesuite/truffle-core)
- [EthereumJS TestRPC v3.0.5](https://github.com/ethereumjs/testrpc)
- [Zeppelin Solidity v1.2.0](https://github.com/OpenZeppelin/zeppelin-solidity)

## How to test

Open the terminal and run the following commands:

```sh
$ cd dmarket-smartcontract
$ truffle migrate
```

NOTE: All tests must be run separately as specified.


## Deployment

To deploy smart contracts to live network do the following steps:
1. Go to the smart contract folder and run truffle console:
```sh
$ cd dmarket-smartcontract
$ truffle console
```
2. Inside truffle console, invoke "migrate" command to deploy contracts:
```sh
truffle> migrate
```
