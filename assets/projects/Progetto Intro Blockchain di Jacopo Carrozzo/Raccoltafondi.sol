// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Raccoltafondi {

    uint public saldoTotaleRaccolto;
    address public indirizzoManager;
    uint public obbiettivo;
    uint public donatori;
    bool public raccoltaConclusa;


    constructor(uint _obbiettivo) { 
        saldoTotaleRaccolto = 0;      // Imposta il valore della variabile 
        indirizzoManager = msg.sender;   // Assegna l'indirizzo del creatore del contratto alla variabile indirizzoManager
        obbiettivo = _obbiettivo;     // Il magager deve determire l'obbiettivo
    }

    function dona() public payable {                        
        saldoTotaleRaccolto += msg.value;    //incrementa il saldo totale con l'importo ricevuto.
        donatori += 1;   //incrementa il numero dei donatori 
    }

    function preleva() public {
    require(msg.sender == indirizzoManager, "Solo il manager puo' prelevare");
    payable(indirizzoManager).transfer(address(this).balance);
    }

    function chiudiRaccolta() public {
    require(msg.sender == indirizzoManager, "Solo il manager puo' chiudere la raccolta");
    raccoltaConclusa = true;
    }

    function verificaObiettivo() public view returns (bool) {
        return saldoTotaleRaccolto >= obbiettivo;
    }
}