// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract TokenContract {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    mapping(address=>uint256) public balanceOf;
    mapping(address =>mapping(address=>uint256)) public allowance;
    
    constructor(){
        name = "phi";
        symbol = "phi";
        decimals = 18;
        totalSupply = 33000000 * (uint256(10) ** decimals);
        balanceOf[msg.sender] = totalSupply;
    }

    modifier requireBalance(uint256 balance,uint256 _value){
        require(balance >= _value);
        _;
    }

    event Transfer(address indexed _from,address indexed _to,uint256 _value);
    event Approval(address indexed _owner,address indexed _spender,uint256 _value);

    function transfer(address _to,uint256 _value) public  requireBalance(balanceOf[msg.sender],_value) returns(bool){
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        emit Transfer(msg.sender,_to,_value);
        return true;
    }

    function approve(address _spender,uint256 _value) public returns(bool){
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender,_spender,_value);
        return true;
    }
    
    function transferFrom(address _from,address _to,uint256 _value)  public requireBalance(balanceOf[_from],_value) requireBalance(allowance[_from][msg.sender],_value) returns(bool) {
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from,_to,_value);
        return true;
    }

}
