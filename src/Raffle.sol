// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/**
* @title A smample Raffle contract
* @author Alekseenko Leonid 
* @notice This contract is for creating a sample rafle
* @dev ImplementsChainLincVFRv2.5
*/

contract Raffle {  

    uint256 private immutable i_entranceFee;

    error Raffle_SendMoreToEnterRaffle();

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() public payable {
        if(msg.value < i_entranceFee) {
            revert Raffle_SendMoreToEnterRaffle();
        }
    }

    function pickWinner() public {}

    /* Getters **/

    function getEntranceFee() external view returns (uint256){
        return i_entranceFee;
    }
}
