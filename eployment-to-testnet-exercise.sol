https://docs.base.org/base-camp/docs/deployment-to-testnet/deployment-to-testnet-exercise/

CODE:

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicMath {
    function adder(uint256 _a, uint256 _b) public pure returns (uint256 sum, bool error) {
        unchecked {
            sum = _a + _b;
            error = sum < _a;
        }
    }

    function subtractor(uint256 _a, uint256 _b) public pure returns (uint256 difference, bool error) {
        unchecked {
            if (_b <= _a) {
                difference = _a - _b;
                error = false;
            } else {
                difference = 0;
                error = true;
            }
        }
    }
}
