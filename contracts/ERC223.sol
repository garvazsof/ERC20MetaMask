pragma solidity ^0.5.0;

contract ERC223 {
    function transfer(address to, uint value, bytes memory data) public;
    event Transfer(address indexed from, address indexed to, uint value, bytes indexed data);
}