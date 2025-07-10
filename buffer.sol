pragma solidity ^0.4.24;

contract Overflow {
    uint8 public count = 255;

    function increment() public {
        count += 1;
    }
}
