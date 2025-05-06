// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GMLogger {
    struct GMRecord {
        uint32 timestamp;
        uint32 callNumber;
        address caller;
    }
    
    GMRecord[] private _gmRecords; 
    mapping(address => uint256) private _callCounts;
    event GMCalled(address caller, uint256 timestamp);
    
    function GM() external {
        _callCounts[msg.sender] += 1;
        
        GMRecord memory newRecord = GMRecord({
            timestamp: uint32(block.timestamp),
            callNumber: uint32(_gmRecords.length + 1),
            caller: msg.sender
        });
        
        _gmRecords.push(newRecord);
        emit GMCalled(msg.sender, block.timestamp);
    }
    
    function getGMCalls(address user) external view returns (uint256) {
        return _callCounts[user];
    }
    
    function getTotalGMCalls() external view returns (uint256) {
        return _gmRecords.length;
    }
    
}