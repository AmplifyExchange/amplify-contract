/* global web3 */
const BigNumber = web3.BigNumber

module.exports = amp => {
  let precisionFactor = new BigNumber(10).pow(18)
  return new BigNumber(amp).times(precisionFactor)
}
