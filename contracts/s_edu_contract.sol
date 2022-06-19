pragma solidity ^0.4.11;

// 교육참가자 토큰 구입자 로그인 가능
// 교육참가자 교육 구입 가능(최소 10 wei이상)
contract ShEdu_login {
    // 상태 변수 선언
    string public name; // 토큰 이름
    string public symbol; // 토큰 단위
    uint8 public decimals; // 소수점 이하 자릿수
    uint256 public totalSupply; // 토큰 총량
    mapping (address => uint256) public balanceOf; // 각 주소의 잔고
    mapping (address => int8) public loginList; // 로그인 가능 리스트
    address public owner; // 소유자 주소

    // 수식자
    modifier onlyOwner() { if (msg.sender != owner) throw; _; }

    // 이벤트 알림
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Loginlisted(address indexed target);
    event DeleteFromLoginlist(address indexed target);
    event RejectedPaymentToLoginlistedAddr(address indexed from, address indexed to, uint256 value);
    event RejectedPaymentFromLoginlistedAddr(address indexed from, address indexed to, uint256 value);

    //
    function ShEdu_login(uint256 _supply, string _name, string _symbol, uint8 _decimals) {
        balanceOf[msg.sender] = _supply;
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _supply;
        owner = msg.sender; // 소유자 주소 설정
    }

    // 주소를 로그인리스트에 등록, 처음에는 로그인 리스트에 오르면 교육구입비용 지원
    function loginlisting(address _addr) {
        loginList[_addr] = 1;
        Loginlisted(_addr);
    }

    // 교육구입비용 지원
    function edulisting(address _addr) {
        if (loginList[_addr] <= 0) throw;
        else {
            balanceOf[owner] -= 5;
            balanceOf[_addr] += 5;
            Transfer(owner, _addr, 5);
        }
    }

    // 주소를 로그인리스트에서 제거 NFT 판매
    function deleteFromLoginlist(address _addr) {
        if (loginList[_addr] <= 0) throw;
        else {
            loginList[_addr] = -1;
            DeleteFromLoginlist(_addr);
            balanceOf[owner] -= 3;
            balanceOf[_addr] += 3;
            Transfer(owner, _addr, 3);
        }
    }

    // (7) 교육등록
    function eduapply(address _to, uint256 _value) {
        // 부정 송금 확인
        if (balanceOf[msg.sender] < _value) {
            //require(balanceOf[msg.sender] < _value, "no Ether");
            throw;
        }
        if (balanceOf[_to] + _value < balanceOf[_to]) throw;
        // 로그인리스트에 미존재하는 주소는 교육 구입 불가
        if (loginList[msg.sender] <= 0) {
            RejectedPaymentFromLoginlistedAddr(msg.sender, _to, _value);
            //require(loginList[msg.sender] <= 0, "no Right2");
        } else if (loginList[_to] <= 0) {
            RejectedPaymentToLoginlistedAddr(msg.sender, _to, _value);

        } else {
            balanceOf[msg.sender] -= _value;
            balanceOf[_to] += _value;
            Transfer(msg.sender, _to, _value);
        }
    }
}
