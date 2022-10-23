
const CounterContract = artifacts.require("Counter")

module.exports = function (deployer) {
    deployer.deploy(CounterContract)
}