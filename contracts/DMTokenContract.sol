pragma solidity ^0.4.11;

import './StandardToken.sol';
import './Ownable.sol';


contract DMarketToken is StandardToken, Ownable {
    string public constant name = "Dmarket token";
    string public constant symbol = "DMT";
    uint public constant decimals = 8;

    using SafeMath for uint256;

    // timestamps for first and second Steps
    uint public startFirstStep;
    uint public endFirstStep;
    uint public starSecondStep;
    uint public endSecondStep;

    // address where funds are collected
    address public wallet;

    // how many token units a buyer gets per wei
    uint256 public rate;

    uint256 public minTransactionAmount;

    uint256 public raisedForEther = 0;
    uint256 public raisedForBitCoin = 0;
    uint256 public raisedForSkin = 0;

    modifier inActivePeriod() {
        require((startFirstStep < now && now <= endFirstStep) || (starSecondStep < now && now <= endSecondStep));
        _;
    }

    function DMarketToken(address _wallet, uint _startF, uint _endF, uint _startS, uint _endS) {
        require(_wallet != 0x0);
        require(_startF < _endF);
        require(_startS < _endS);

        // accumulation wallet
        wallet = _wallet;

        //50,000,000 Dmarket tokens
        totalSupply = 50000000;

        // 1 ETH = 1,000 Dmarket
        rate = 1000;

        // minimal invest
        minTransactionAmount = 0.1 ether;

        startFirstStep = _startF;
        endFirstStep = _endF;
        starSecondStep = _startS;
        endSecondStep = _endS;

    }

    function setupPeriodForFirstStep(uint _start, uint _end) onlyOwner {
        require(_start < _end);
        startFirstStep = _start;
        endFirstStep = _end;
    }

    function setupPeriodForSecondStep(uint _start, uint _end) onlyOwner {
        require(_start < _end);
        starSecondStep = _start;
        endSecondStep = _end;
    }

    // fallback function can be used to buy tokens
    function () inActivePeriod payable {
        buyTokens(msg.sender);
    }

    // low level token purchase function
    function buyTokens(address _sender) inActivePeriod payable {
        require(_sender != 0x0);
        require(msg.value >= minTransactionAmount);

        uint256 weiAmount = msg.value;

        raisedForEther = raisedForEther.add(weiAmount);

        // calculate token amount to be created
        uint256 tokens = weiAmount.mul(rate);
        tokens += getBonus(tokens);

        tokenReserve(_sender, tokens);

        forwardFunds();
    }

    // send ether to the fund collection wallet
    // override to create custom fund forwarding mechanisms
    function forwardFunds() internal {
        wallet.transfer(msg.value);
    }

    /*
    *    Step 1:
    *        Day 1: +10% bonus
    *        Day 2: +5% bonus
    *        Day 3: +3% bonus
    *        Day 4: no bonuses
    */
    function getBonus(uint256 _tokens) constant returns (uint256 bonus) {
        require(_tokens != 0);
        if (1 == getCurrentPeriod()) {
            if (startFirstStep <= now && now < startFirstStep + 1 days) {
                return _tokens.div(10);
            } else if (startFirstStep + 1 days <= now && now < startFirstStep + 2 days ) {
                return _tokens.div(20);
            } else if (startFirstStep + 2 days <= now && now < startFirstStep + 3 days ) {
                return _tokens.mul(3).div(100);
            }
        }

        return 0;
    }

    function getCurrentPeriod() inActivePeriod constant returns (uint){
        if ((startFirstStep < now && now <= endFirstStep)) {
            return 1;
        } else if ((starSecondStep < now && now <= endSecondStep)) {
            return 2;
        } else {
            return 0;
        }
    }

    function tokenReserve(address _to, uint256 _value) returns (bool) {
        balances[_to] = balances[_to].add(_value);
        Transfer(msg.sender, _to, _value);
        return true;
    }
}