// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./BroManager.sol";

struct Bro {
    uint256 dna;
    uint8 dickSize;
    uint32 fatherId;
}

contract BroFactory is BroManager {
    Bro[] public bros;
    mapping(uint32 => address) public broToOwner;
    mapping(address => uint256) ownerBroCount;

    event MintBro(address indexed from, uint32 indexed id);

    constructor() {}

    function mintBro() public payable {
        require(msg.value == mintPrice);
        bros.push(Bro(pseudoRandom(), uint8(pseudoRandom() % 5), 0));
        uint32 id = uint32(bros.length);
        broToOwner[id] = msg.sender;
        ownerBroCount[msg.sender]++;
        emit MintBro(msg.sender, id);
    }

    function getBrosByOwner(address _owner) public view returns (Bro[] memory) {
        Bro[] memory result = new Bro[](ownerBroCount[_owner]);
        uint32 counter = 0;
        for (uint32 i = 0; i < bros.length; i++) {
            if (broToOwner[i] == _owner) {
                result[counter] = bros[i];
                counter++;
            }
        }
        return result;
    }
}
