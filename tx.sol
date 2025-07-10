pragma solidity ^0.8.0;

contract TxOrigin {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function transfer(address payable to) public {
        require(tx.origin == owner);
        to.transfer(address(this).balance);
    }

    receive() external payable {}
}
