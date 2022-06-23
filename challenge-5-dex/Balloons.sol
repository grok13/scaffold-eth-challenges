pragma solidity >=0.8.0 <0.9.0;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Balloons is ERC20 {
    constructor() ERC20("Balloons", "BAL") {
        // **You can update the msg.sender address with your
        // front-end address to mint yourself tokens.
        //_mint(0xc2E34e6662EA55fC32b10aa200670a23960231E2, 1000 ether);
        // This mints to the deployer
        _mint(msg.sender, 1000 ether);
    }
}
