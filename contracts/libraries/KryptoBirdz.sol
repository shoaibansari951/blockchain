// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import './ERC721Connector.sol';


contract KryptoBirdz is ERC721Connector {
    string[] public kryptoBirdz;
    mapping(string => bool) public kryptoBirdzExist;
    function mint(string memory _kryptoBirdz) public {
        require(!kryptoBirdzExist[_kryptoBirdz], "KryptoBirdz already exists");
        kryptoBirdz.push(_kryptoBirdz);
        uint id= kryptoBirdz.length - 1;
        _mint(msg.sender, id);
        kryptoBirdzExist[_kryptoBirdz] = true;
    }
    constructor () ERC721Connector('KryptoBirdz','KBIRDZ')  {
       
    }
}