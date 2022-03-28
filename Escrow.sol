// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.13;

//Compra-venta de una propiedad con una garantia.
contract Escrow{
    //dirección del pagador
    address public payer;
    //Dirección del tenedor de una "propiedad"
    address payable public payee;
    //Dirección del abogado
    address public lawyer;
    //Cantidad de dinero
    uint public amount;
    //Constructor del smart contract
    constructor(address _payer, address payable _payee, uint _amount){
        payer = _payer;
        payee = _payee;
        lawyer = msg.sender;
        amount = _amount;
    }

    //Función para depositar el dinero
    function deposit() payable public{
        require(msg.sender == payer, "Sender must be the payer");
        require(address(this).balance <= amount, "");
    }

    //Función para liberar la propiedad una vez pagada.
    function release() public{
        require(address(this).balance == amount, "Cannot release funds before the amount is set ");
        require(msg.sender == lawyer, "only lawyer can release funds");
        payee.transfer(amount);
    }

    //Obtener el balance de la billetera.
    function balanceOf() view public returns(uint) {
        return address(this).balance;
    }


}