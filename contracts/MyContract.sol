// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract EmailTxHashStore {
    mapping(string => string) public emailTxHashes;

    function storeEmailTxHash(string memory email, string memory txHash) public {
        emailTxHashes[email] = txHash;
    }

    function getEmailTxHash(string memory email) public view returns (string memory) {
        return emailTxHashes[email];
    }
}