https://docs.base.org/base-camp/docs/structs/structs-exercise/

CODE:

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract GarageManager {
    // Custom error declaration
    error BadCarIndex(uint256 index);

    // Struct to represent a car
    struct Car {
        string make;
        string model;
        string color;
        uint256 numberOfDoors;
    }

    // Mapping from address to array of cars
    mapping(address => Car[]) private garage;

    // Function to add a new car to the sender's garage
    function addCar(
        string calldata _make,
        string calldata _model,
        string calldata _color,
        uint256 _numberOfDoors
    ) external {
        garage[msg.sender].push(Car(_make, _model, _color, _numberOfDoors));
    }

    // Function to get all cars belonging to the sender
    function getMyCars() external view returns (Car[] memory) {
        return garage[msg.sender];
    }

    // Function to get all cars belonging to a specific user
    function getUserCars(address _user) external view returns (Car[] memory) {
        return garage[_user];
    }

    // Function to update the details of a car in the sender's garage
    function updateCar(
        uint256 _index,
        string calldata _make,
        string calldata _model,
        string calldata _color,
        uint256 _numberOfDoors
    ) external {
        Car[] storage cars = garage[msg.sender];

        // Ensure that the car index is valid
        require(_index < cars.length, "BadCarIndex");

        // Update the details of the specified car
        Car storage carToUpdate = cars[_index];
        carToUpdate.make = _make;
        carToUpdate.model = _model;
        carToUpdate.color = _color;
        carToUpdate.numberOfDoors = _numberOfDoors;
    }

    // Function to reset the sender's garage by deleting all cars
    function resetMyGarage() external {
        delete garage[msg.sender];
    }
}
