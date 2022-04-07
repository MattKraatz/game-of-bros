// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BroManager is Ownable {
    constructor() {}

    uint256 mintPrice = 0.001 ether;

    function updateMintPrice(uint256 _price) external onlyOwner {
        console.log("Changing mint price from '%s' to '%s'", mintPrice, _price);
        mintPrice = _price;
    }

    uint256 randNonce = 0;

    function pseudoRandom() internal returns (uint256) {
        randNonce++;
        return
            uint256(
                keccak256(
                    abi.encodePacked(block.timestamp, msg.sender, randNonce)
                )
            );
    }
}
