pragma solidity ^0.4.11;

import './Ownable.sol';


contract ReservationStorage is Ownable{

    struct Box {
        address recipient;
        uint256 token;
        uint256 value;
        uint createAt;
    }

    /**
    *  coinId => [ehterAccount => box ]
    */
    mapping ( uint => mapping (address => Box[]) ) public storageEthereumData;
    mapping ( uint => mapping (bytes32 => Box[]) ) public storageCoinsData;

    function reservationFromEthereum(address _to, uint256 _value, uint _token) onlyOwner {
        require(_to != 0x0);
        storageEthereumData[0][_to].push(Box({
            recipient: _to,
            token: _token,
            value:_value,
            createAt: now
        }));
    }

    function reservationFromBackend(uint coinId, bytes32 coinAccount, address etherAccount, uint256 value, uint token) onlyOwner {
        require(etherAccount != 0x0);

        storageCoinsData[coinId][coinAccount].push(Box({
            recipient: etherAccount,
            token: token,
            value: value,
            createAt: now
        }));
    }

}
