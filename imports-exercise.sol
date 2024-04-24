https://docs.base.org/base-camp/docs/imports/imports-exercise/


CODE:

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "https://raw.githubusercontent.com/avocadodefi/base-camp/main/SillyStringUtils.sol";

contract ImportsExercise {
    using SillyStringUtils for string;

    SillyStringUtils.Haiku public haiku;

    function saveHaiku(
        string calldata _line1,
        string calldata _line2,
        string calldata _line3
    ) external {
        require(bytes(_line1).length > 0 && bytes(_line2).length > 0 && bytes(_line3).length > 0, "All lines must be non-empty");
        
        haiku = SillyStringUtils.Haiku(
            _line1,
            _line2,
            _line3
        );
    }

    function getHaiku() external view returns (SillyStringUtils.Haiku memory) {
        return haiku;
    }

    function shruggieHaiku() external view returns (SillyStringUtils.Haiku memory) {
        return SillyStringUtils.Haiku(
            haiku.line1,
            haiku.line2,
            haiku.line3.shruggie()
        );
    }
}
