**Metacrafters**

In this solidity smart contract, I showcase the importance of function like require, assert and revert. 
Require first check the condition before any transaction is made. 
Assert is like a safety mechanism that holds the condition that always need to be true.
Revert is like a undo button if in any part of our contract we want to revert the transaction after a particular condition is met then we will revert it.

When I deploy this smart contract, as per the require condition **msg.value==amount** so, the amount we put in deposit section same amount we have to put in value section.
then we see the balance fom balance function, withdraw the ethers from withdraw function. and know the owner address by getOwner function.
