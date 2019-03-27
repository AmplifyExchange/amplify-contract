/* global artifacts */

let Amplify = artifacts.require('./Amplify.sol')

module.exports = function (deployer, network, accounts) {
  deployer.deploy(Amplify)
}
