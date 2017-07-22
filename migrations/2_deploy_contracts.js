var MDTokenContract = artifacts.require("./MDTokenContract.sol");

module.exports = function(deployer) {
  deployer.deploy(MDTokenContract);
};
