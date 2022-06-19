pragma solidity ^0.8.6;

import "https://github.com/Oxcert/ethereum-erc721/src/contracts/tokens/nf-token-metadata.sol";
import "https://github.com/Oxcert/ethereum-erc721/src/contracts/ownership/ownable.sol"

contract ERC721 is NFTokenMetadata, Ownable{
    constructor(){
        nftName = "Shinhan NFT";
        nftSymbol ="HTP";
    }
    function mint(address _to, unit256 _tokenId, string calldata _uri) external onlyOwner{
        sper._mint(_to,_tokenID);
        super._setTokenUri(_toeknId,_uri);
    }
}
