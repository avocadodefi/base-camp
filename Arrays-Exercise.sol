https://docs.base.org/base-camp/docs/arrays/arrays-exercise/

CODE:

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ArraysExercise {
    uint[] public numbers = [1,2,3,4,5,6,7,8,9,10];
    address[] public senders;
    uint[] public timestamps;

    // Return the complete array 'numbers'
    function getNumbers() public view returns (uint[] memory) {
        return numbers;
    }

    // Reset the array 'numbers' to its initial values
    function resetNumbers() public {
        numbers = [1,2,3,4,5,6,7,8,9,10];
    }

    // Append an array to 'numbers'
    function appendToNumbers(uint[] calldata _toAppend) public {
        for (uint i = 0; i < _toAppend.length; i++) {
            numbers.push(_toAppend[i]);
        }
    }

    // Save timestamp and sender address
    function saveTimestamp(uint _unixTimestamp) public {
        senders.push(msg.sender);
        timestamps.push(_unixTimestamp);
    }

    // Filter timestamps post Y2K and their corresponding sender addresses
    function afterY2K() public view returns (uint[] memory, address[] memory) {
        uint count = 0;
        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                count++;
            }
        }

        uint[] memory postY2KTimestamps = new uint[](count);
        address[] memory postY2KSenders = new address[](count);
        uint j = 0;
        for (uint i = 0; i < timestamps.length; i++) {
            if (timestamps[i] > 946702800) {
                postY2KTimestamps[j] = timestamps[i];
                postY2KSenders[j] = senders[i];
                j++;
            }
        }
        return (postY2KTimestamps, postY2KSenders);
    }

    // Reset senders and timestamps arrays
    function resetSenders() public {
        delete senders;
    }

    function resetTimestamps() public {
        delete timestamps;
    }
}
