var Migrations = artifacts.require("./v0.2/Migrations.sol");

module.exports = function(deployer) {
  deployer.deploy(Migrations);
};
