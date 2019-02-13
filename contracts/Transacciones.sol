pragma solidity ^0.5.0;

contract Transacciones{
    
    mapping(address => bytes32[]) mRegistros;
    mapping(address => uint) mRegistrosI;
    
    
    function recordTransaccion(bytes32 _mensaje, address _address) public returns (bool result) {
        
        bytes32[] storage txsls = mRegistros[_address];
        
        txsls.push(_mensaje);
        mRegistrosI[_address] = txsls.length;
        
        return true;
    }
    
    function getTransactions(address _address) public view returns(bytes32[] memory mRegistrosLs){
        bytes32[] memory txsls = mRegistros[_address];
        
        return txsls;
    }
    
    function stringToBytes32(string memory source) internal pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }
    
        assembly {
            result := mload(add(source, 32))
        }
    }
    
}