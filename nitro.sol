/**
 *Submitted for verification at basescan.org on 2025-01-16
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract RocketActions {
    bool public isTurboOn;
    uint public nitroAmount;
    bool public isMoonModeOn;

    event TurboActivated(bool state);
    event NitroActivated(uint amount);
    event MoonModeToggled(bool state);

    constructor() {
        isTurboOn = false;
        nitroAmount = 0;
        isMoonModeOn = false;
    }

    function toggleTurbo() public {
        isTurboOn = !isTurboOn;
        emit TurboActivated(isTurboOn);
    }

    // Fonction pour activer la nitro avec une quantité aléatoire
    function activateNitro() public {
        require(isTurboOn, "Le turbo doit etre active pour utiliser la nitro.");
        nitroAmount = uint(keccak256(abi.encodePacked(block.timestamp, block.prevrandao))) % 101; // Quantite entre 0 et 100
        emit NitroActivated(nitroAmount);
    }

    // Fonction pour allumer ou eteindre le mode "Moon"
    function toggleMoonMode() public {
        require(isTurboOn, "Le turbo doit etre active pour activer le mode Moon.");
        isMoonModeOn = !isMoonModeOn;
        emit MoonModeToggled(isMoonModeOn);
    }

    // Fonction pour obtenir l'etat complet de la fusee
    function getRocketStatus() public view returns (string memory) {
        string memory turboStatus = isTurboOn ? "active" : "desactive";
        string memory moonModeStatus = isMoonModeOn ? "active" : "desactive";
        return string(abi.encodePacked(
            "Turbo: ", turboStatus, ", Mode Moon: ", moonModeStatus, ", Quantite de nitro: ", uintToString(nitroAmount)
        ));
    }

    // Fonction utilitaire pour convertir un uint en string
    function uintToString(uint v) internal pure returns (string memory) {
        if (v == 0) {
            return "0";
        }
        uint maxLen = 100;
        bytes memory reversed = new bytes(maxLen);
        uint i = 0;
        while (v != 0) {
            uint remainder = v % 10;
            v = v / 10;
            reversed[i++] = bytes1(uint8(48 + remainder));
        }
        bytes memory s = new bytes(i);
        for (uint j = 0; j < i; j++) {
            s[j] = reversed[i - 1 - j];
        }
        return string(s);
    }
}
