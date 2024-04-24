https://docs.base.org/base-camp/docs/new-keyword/new-keyword-exercise/

Deploy Contract, switch to AdressBookFactory, deploy also, copy this contract ID
CODE:

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract AddressBook is Ownable {
    struct Contact {
        uint id;
        string firstName;
        string lastName;
        uint[] phoneNumbers;
    }

    Contact[] private contacts;
    mapping(uint => uint) private idToIndex;
    uint private nextId = 1;

    event ContactAdded(uint indexed id, string firstName, string lastName, uint[] phoneNumbers);
    event ContactDeleted(uint indexed id);

    constructor(address initialOwner) Ownable(initialOwner) {}

    function addContact(string calldata firstName, string calldata lastName, uint[] calldata phoneNumbers) external onlyOwner {
        contacts.push(Contact(nextId, firstName, lastName, phoneNumbers));
        idToIndex[nextId] = contacts.length - 1;
        emit ContactAdded(nextId, firstName, lastName, phoneNumbers);
        nextId++;
    }

    function deleteContact(uint id) external onlyOwner {
        uint index = idToIndex[id];
        require(index < contacts.length && contacts[index].id == id, "ContactNotFound");
        
        emit ContactDeleted(id);
        
        if (index < contacts.length - 1) {
            contacts[index] = contacts[contacts.length - 1];
            idToIndex[contacts[index].id] = index;
        }
        contacts.pop();
        delete idToIndex[id];
    }

    function getContact(uint id) external view returns (Contact memory) {
        uint index = idToIndex[id];
        require(index < contacts.length && contacts[index].id == id, "ContactNotFound");
        return contacts[index];
    }

    function getAllContacts() external view returns (Contact[] memory) {
        return contacts;
    }
}

contract AddressBookFactory {
    event AddressBookDeployed(address indexed owner, address indexed addressBook);

    function deploy() external returns (address) {
        AddressBook newAddressBook = new AddressBook(msg.sender);
        emit AddressBookDeployed(msg.sender, address(newAddressBook));
        return address(newAddressBook);
    }
}
