// migrations/2_deploy_contracts.js
var EmailTxHashStore = artifacts.require("./EmailTxHashStore.sol");

module.exports = function(deployer) {
    deployer.deploy(EmailTxHashStore);
};