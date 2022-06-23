pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {
    YourToken public yourToken;
    uint256 public constant tokensPerEth = 100;

    event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
    event SellTokens(
        address seller,
        uint256 amountOfETH,
        uint256 amountOfTokens
    );

    constructor(address tokenAddress) {
        yourToken = YourToken(tokenAddress);
    }

    // ToDo: create a payable buyTokens() function:
    function buyTokens() external payable {
        uint256 amountOfTokens = msg.value * tokensPerEth;
        yourToken.transfer(msg.sender, amountOfTokens);
        emit BuyTokens(msg.sender, msg.value, amountOfTokens);
    }

    // ToDo: create a withdraw() function that lets the owner withdraw ETH
    function withdraw() external onlyOwner {
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success, "Failed to send Ether");
    }

    // ToDo: create a sellTokens(uint256 _amount) function:
    function sellTokens(uint256 amountOfTokens) external {
        bool success = yourToken.transferFrom(
            msg.sender,
            address(this),
            amountOfTokens
        );
        require(success, "Failed to send token");
        uint amountOfETH = amountOfTokens / tokensPerEth;
        (success, ) = payable(msg.sender).call{value: amountOfETH}("");
        require(success, "Failed to send Ether");
        emit SellTokens(msg.sender, amountOfETH, amountOfTokens);
    }
}
