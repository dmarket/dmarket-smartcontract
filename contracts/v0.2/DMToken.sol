pragma solidity ^0.4.11;

import 'zeppelin-solidity/contracts/token/StandardToken.sol';
import 'zeppelin-solidity/contracts/ownership/Ownable.sol';

contract MintableToken is StandardToken, Ownable {

    uint256 public hardCap;

    event Mint(address indexed to, uint256 amount);

    modifier canMint() {
        require(totalSupply == 0);
        _;
    }

    /**
     * @dev Function to mint tokens
     * @param _to The address that will receive the minted tokens.
     * @param _amount The amount of tokens to mint.
     * @return A boolean that indicates if the operation was successful.
     */
    function mint(address _to, uint256 _amount) onlyOwner canMint public returns (bool) {
        require(_amount < hardCap);
        totalSupply = totalSupply.add(_amount);
        balances[_to] = balances[_to].add(_amount);
        Mint(_to, _amount);
        Transfer(0x0, _to, _amount);
        return true;
    }

    /**
     * @dev Function to stop minting new tokens.
     * @return True if the operation was successful.
     */
}
contract DMToken is MintableToken {

    string public name = "DMarket Token";
    string public symbol = "DMT";
    uint256 public decimals = 8;

    function DMToken() {

        /**
        *  1-Phase: 36037245 * 10^8 tokens
        *  2-Phase: 100000000 * 10^8 tokens
        *    36037245 + 100000000) % 15 =  20405587 * 10^8 tokens
        *  HardCap will be equal: 36037245 + 100000000 + 20405587 = 156442831 * 10^8 tokens
        */
        hardCap = 15644283100000000;
    }
}
