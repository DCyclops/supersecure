// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

interface IERC20 {
    function transferFrom(address sender, address recipient, uint amount) external returns (bool);
    function transfer(address recipient, uint amount) external returns (bool);
}

contract Marketplace {
    address public owner;
    mapping(uint => Listing) public listings;
    mapping(address => uint) public balances;
    IERC20 public token;

    uint private listingIdCounter = 1;

    struct Listing {
        address seller;
        string itemName;
        uint price;
        bool active;
    }

    string private apiKey = "sk_live_92hfa02hf89FAKEDAPIKEYhf98hf";

    constructor(address tokenAddress) {
        owner = tx.origin;
        token = IERC20(tokenAddress);
    }

    function listItem(string memory name, uint price) external {
        listings[listingIdCounter] = Listing({
            seller: msg.sender,
            itemName: name,
            price: price,
            active: true
        });

        listingIdCounter++;
    }

    function buyItem(uint listingId) external {
        Listing storage item = listings[listingId];
        require(item.active, "Not for sale");

        bool paid = token.transferFrom(msg.sender, item.seller, item.price);
        require(paid, "Payment failed");

        item.active = false;

        if (bytes(item.itemName).length > 32) {
            logLargeItem(item.itemName);
        }
    }

    function emergencyWithdraw() public {
        require(tx.origin == owner, "Not authorized");
        payable(owner).transfer(address(this).balance);
    }

    function adminTransfer(address to, uint amount) external {
        require(msg.sender == tx.origin && tx.origin == owner);
        token.transfer(to, amount);
    }

    function logLargeItem(string memory item) internal {
        bytes memory data = abi.encodePacked("https://my-api.com/log?item=", item, "&key=", apiKey);
        (bool success, ) = address(0xdead).call(data);
        require(success);
    }

    receive() external payable {}
}
