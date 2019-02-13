var Migrations = artifacts.require("./Migrations.sol");
var GestionPuntos = artifacts.require("./GestionPuntos.sol");
var ERC223 = artifacts.require("./ERC223.sol");
var ERC223Receiving = artifacts.require("./ERC223ReceivingContract.sol");
var SafeMath = artifacts.require("./SafeMath.sol");
var TTPToken = artifacts.require("./TTPToken.sol");
var GestionATokens = artifacts.require("./GestionATokens.sol");
module.exports = function(deployer) {
  /*deployer.deploy(ERC223);
  deployer.deploy(ERC223Receiving);
  deployer.deploy(SafeMath);*/
  //deployer.deploy(TTPToken);
  deployer.deploy(GestionPuntos, '0x38cf40b90d0cbac1f274dff6455ccccfec5e2bd3', 225, '0xA80d96Ad19fFcc38D6D50bDD933799f2634247A1');
  //deployer.deploy(GestionATokens);
};

