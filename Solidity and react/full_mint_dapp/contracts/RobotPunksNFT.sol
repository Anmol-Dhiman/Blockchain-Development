// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RobotPunksNFT is ERC721, Ownable {
    uint256 public mintPrice;
    // current number of nft while minting
    uint256 public totalSupply;
    // maximum nft that can be minted
    uint256 public maxSupply;
    // max number of nft a specific wallet can mint
    uint256 public maxPerWallet;
    // when the user can mint, this can be changed by owner
    bool public isPublicMineEnabled;
    // for open sea the locate the location of images
    string internal baseTokenUri;
    // this is the walled address where we are going to withdraw all the funds which come to this contract for
    // minting the nft
    address payable public withdrawWallet;
    // to keep the track of all the mints which are completed
    mapping(address => uint256) public walletMints;

    // erc721 contract takes two arguments : - the name and the symbol
    constructor() payable ERC721("RobotPunks", "RP") {
        mintPrice = 0.002 ether;

        // as we started so total supply will be zero
        totalSupply = 0;
        maxSupply = 1000;
        maxPerWallet = 3;
    }

    function setIsPublicMintEnabled(
        bool _isPublicMintEnabled
    ) external onlyOwner {
        isPublicMineEnabled = _isPublicMintEnabled;
    }

    // calldata is just like memory but we can only read the data we cannot write the data
    function setBaseTokenUri(string calldata _baseTokenUri) external onlyOwner {
        baseTokenUri = _baseTokenUri;
    }

    // open sea will call this function to grab the images
    function tokenURI(
        uint256 _tokenId
    ) public view override returns (string memory) {
        require(_exists(_tokenId), "Token does not exist!");

        // sending the url to opensea by concatinating the
        // base url with token id and return this into json format
        return
            string(
                abi.encodePacked(
                    baseTokenUri,
                    Strings.toString(_tokenId),
                    ".json"
                )
            );
    }

    function withdraw() external onlyOwner {
        (bool send, ) = withdrawWallet.call{value: address(this).balance}("");
        require(send, "Failed to send ether!");
    }

    function mint(uint256 _quantity) public payable {
        require(isPublicMineEnabled, "minting is not enabled!");
        require(
            msg.value == _quantity * mintPrice,
            "not enough money transfered"
        );
        require(totalSupply + _quantity <= maxSupply, "sold out");
        require(
            walletMints[msg.sender] + _quantity <= maxPerWallet,
            "exceed max limit"
        );

        for (uint256 i = 0; i < _quantity; i++) {
            //    change the state before push to prevent reentracy
            uint256 newTokenId = totalSupply + 1;
            totalSupply++;
            _safeMint(msg.sender, newTokenId);
        }
    }
}
