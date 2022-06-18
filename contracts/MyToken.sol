pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20{
  uint public INITIAL_SUPPLY = 1000000000000000000;

  constructor() public ERC20("My Token","NFT"){
    _mint(msg.sender, INITIAL_SUPPLY);
  }
}
