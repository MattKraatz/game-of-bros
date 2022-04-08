// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract BroFactory is ERC721, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("Brosky", "BRO") {}

    function _baseURI() internal pure override returns (string memory) {
        return "https://s3.eu-west-2.amazonaws.com/nftdata.timefrogs.com/meta/"; // borrowed from Time Frogs
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
    }

    uint256 mintPrice = 0.001 ether;

    function updateMintPrice(uint256 _price) external onlyOwner {
        console.log("Changing mint price from '%s' to '%s'", mintPrice, _price);
        mintPrice = _price;
    }

    function mintBro() public payable {
        require(msg.value == mintPrice);
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(msg.sender, tokenId);
    }
}
