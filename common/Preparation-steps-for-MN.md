# Preparation steps to run a Deviant Masternode<br />
Such guide cover the following points:<br />
1. Enable Coin Control
2. Masternode address
3. Masternode private key
4. Masternode collateral<br />

## Enable Coin Control<br />
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
In such menù you're free to select the sending inputs, leaving untouched collaterals and staking ones.

## Masternode address
Open the receiving address menù from your wallet<br />
<p><img src="/images/rec-address.png" /></p>
<br />
Click "New" push button, then fill the label field. Confirm with "Ok" push button.
The results will looks like the image below (MN label as example)
<br />
<p><img src="/images/mn-label.png" /></p>
<br />
From now on the masternode address will be referenced by <br />
`<MN ADDR>`

## Masternode private key
Tha Masternode private key is a unique key that identify a Masternode.
Such key can be generated from RPC console (aka Debug Console) embedded in the wallet, with command <br />
`masternode genkey`<br />
<p><img src="/images/rpc-console.png" /></p>
<br />
<p><img src="/images/mn-genkey.png" /></p>
<br />
<p><img src="/images/mn-genkey-out.png" /></p>
<br />
From now on the private key will be referenced by <br />
`<MN PRIV KEY>`

## Masternode collateral
The Masternode collater is an amount of 5000 DEV that must be locked in order to run a Masternode.
The 5000 DEV become collateral after an user send such amount in one atomic transaction to <MN ADDR>.
Any additional fees must be added to the amount.<br />
<p><img src="/images/send-5000.png" /></p>
<br />
<p><img src="/images/confirm-5000.png" /></p>
<br />
Once the transaction reach 6 confirmations, the "transaction hash" and the related "output index" can be shown via RPC console firing the command:<br />
`masternode outputs`<br />
<p><img src="/images/mn-output.png" /></p>
<br /> 
From now on the "transaction hash" key will be referenced by <br />
`<MN TX-iD>`<br />
the "output index" will be referenced by <br />
`<TX-ID IDX>`
