var DMToken = artifacts.require("./v0.2/DMToken.sol");

module.exports = function(deployer) {
    deployer.deploy(DMToken);
};
