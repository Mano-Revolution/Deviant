# Preparation steps to run a Deviant Masternode<br />
Such guide cover the following points:<br />
1. Configuration of Coin Control
2. Creation of Masternode address
3. Creation of Masternode collateral<br />

## Configuration of Coin Control<br />
The Coin Control feature allow the user to select the input that must be used to withdraw DEV during sending transactions. Without Coin Control you can't select the sending input, so you may corrupt the setup of input stakes, or destroy an unlocked Masternode collateral, for example.
Send menù, without Coin Control looks like the below picture
<br />
![No Coin Control](/images/noCoinControl.png)
<br />
The option to enable Coin Control feature is in the Gui Wallet:<br />
Settings -> Options -> Wallet<br />

Settings Options | Wallet tab
---------------- | ----------
![GUI-options](/images/GUI-options.png) | ![flagCoinControl](/images/flagCoinControl.png)

<br />
In the wallet tab, just flag "Enable Coin Control" to enable such feature.
Once enabled, the Send menù will looks like:<br />
<br />
<p><img src="/images/boxCoinControl.png" alt="CoinControl" /></p>
<br />
Just click on Coin Control, will open a new menù
<br />
<p><img src="/images/intoCoinControl.png" /></p>
<br />
In such menù you'ree free to select the sending inputs, leaving untouched collaterals and staking ones.
