// SPDX-License-Identifier: GPL-3.0
pragma solidity >= 0.5.0 <0.9.0;


 contract HotalRoom{
        enum Statuses {Vacant, Occupied}
        Statuses currentStatus;
        address payable public owner;

    event Occupy (address _occupant, uint _value);

    constructor()  {
    owner= payable(msg.sender);
    currentStatus = Statuses.Vacant;
    }

    modifier onlyWhileVacant {
    require(currentStatus == Statuses.Vacant,"currently occupied.");
    _;
    }

    modifier Costs(uint _amount) {
    require(msg.value >= _amount," Not enough Ether provided.");
    _;
    }

    receive () external payable onlyWhileVacant Costs(2 ether){
    currentStatus = Statuses.Occupied;
    owner.transfer(msg.value);
    emit Occupy(msg.sender,msg.value);
    }
}
