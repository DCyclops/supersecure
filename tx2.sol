pragma solidity ^0.8.0;

contract Uninitialized {
    struct Data {
        uint x;
        uint y;
    }

    Data[] public dataList;

    function add() public {
        Data memory d;
        d.x = 1;
        d.y = 2;
        dataList.push(d);
    }
}
