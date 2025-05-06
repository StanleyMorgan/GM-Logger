// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GMLogger {
    struct GMRecord {
        uint256 timestamp;
        uint256 callNumber;
        address caller;
    }
    
    // Массив для хранения всех записей
    GMRecord[] private _gmRecords;
    
    // Маппинг для подсчета количества вызовов каждого адреса
    mapping(address => uint256) private _callCounts;
    
    // Событие для логирования вызовов
    event GMCalled(address indexed caller, uint256 timestamp, uint256 callNumber);
    
    // Функция для записи вызова GM
    function GM() public {
        // Увеличиваем счетчик вызовов для отправителя
        _callCounts[msg.sender] += 1;
        
        // Создаем новую запись
        GMRecord memory newRecord = GMRecord({
            timestamp: block.timestamp,
            callNumber: _gmRecords.length + 1,
            caller: msg.sender
        });
        
        // Добавляем запись в массив
        _gmRecords.push(newRecord);
        
        // Вызываем событие
        emit GMCalled(msg.sender, block.timestamp, _gmRecords.length);
    }
    
    // Функция для получения количества вызовов GM по адресу
    function getGMCalls(address user) public view returns (uint256) {
        return _callCounts[user];
    }
    
    // Дополнительная функция для получения общего количества записей
    function getTotalGMCalls() public view returns (uint256) {
        return _gmRecords.length;
    }
}