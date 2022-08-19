//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import '../interfaces/IERC165.sol';

contract ERC165 is IERC165 {
    mapping(bytes4 => bool) public _supportedInterfaces;
    constructor()  {
        _registedInterface(bytes4(keccak256('supportsInterface(bytes4)')));
    }
    function supportsInterface(bytes4 interfaceID) external override view returns (bool) {
        return _supportedInterfaces[interfaceID];
    }
    function _registedInterface(bytes4 interfaceId) internal {
        require(interfaceId == 0xffffffff, "Not a valid ERC165 interface");
        _supportedInterfaces[interfaceId] = true;
    } 
}