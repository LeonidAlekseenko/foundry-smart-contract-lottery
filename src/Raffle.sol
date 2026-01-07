// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;


import {VRFConsumerBaseV2Plus} from "@chainlink/contracts@1.1.1/src/v0.8/vrf/dev/VRFConsumerBaseV2Plus.sol";
/**
* @title A smample Raffle contract
* @author Alekseenko Leonid 
* @notice This contract is for creating a sample rafle
* @dev ImplementsChainLincVFRv2.5
*/

contract Raffle {  

    error Raffle_SendMoreToEnterRaffle();
    uint256 private immutable i_entranceFee;
    // @dev The duration of the lottery in second
    uint256 private immutable i_interval;
    uint256 private s_lastTimeStamp;
    address payable[] private s_palayers;
    event RaffleEntered(address indexed player);

    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval = interval;
    }

    function enterRaffle() external payable {
        if(msg.value < i_entranceFee) {
            revert Raffle_SendMoreToEnterRaffle();
        }
        s_palayers.push(payable(msg.sender));
        emit RaffleEntered(msg.sender);
    }

    function pickWinner() external {
        if((block.timestamp - s_lastTimeStamp) < i_interval) {
            revert();
        }
        requestId = s_vrfCoordinator.requestRandomWords(
        VRFV2PlusClient.RandomWordsRequest({
            keyHash: keyHash,
            subId: s_subscriptionId,
            requestConfirmations: requestConfirmations,
            callbackGasLimit: callbackGasLimit,
            numWords: numWords,
            extraArgs: VRFV2PlusClient._argsToBytes(VRFV2PlusClient.ExtraArgsV1({nativePayment: enableNativePayment}))
            })
        );
    }

    /* Getters **/

    function getEntranceFee() external view returns (uint256){
        return i_entranceFee;
    }
}
