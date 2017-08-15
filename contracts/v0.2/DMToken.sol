pragma solidity ^0.4.11;

import 'zeppelin-solidity/contracts/token/MintableToken.sol';

contract DMToken is MintableToken {

    string public name = "DMarket Token";
    string public symbol = "DMT";
    uint256 public decimals = 8;

}
