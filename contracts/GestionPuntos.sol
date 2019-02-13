pragma solidity ^0.5.0;

import "./TTPToken.sol"; 

contract GestionPuntos{
    
    address profesor;
    uint curso;
    TTPToken ttp;
    
    struct Alumno{
        uint matricula;
        string nombreCompleto;
        string campus;
        string grupo;
        address ttpTokenAddress;
    } 

    struct transaccionAlumno{
        string motivo;
        uint tokens;
    }
    
    modifier soloProfesor {
        require(
            msg.sender == profesor,
            "Solo el profesor de este curso puede modificar los valores."
        );
        _;
    }
    
    mapping(uint => Alumno) mRegistros;
    mapping(address => bytes32[]) mRegistrosT;
    mapping(address => uint) mRegistrosI;

    //Constructor, se asigna el profesor y el curso al que pertenece este smart contract
    constructor(address _profesor, uint _curso, address _ttptadd) public{
        profesor = _profesor;
        curso = _curso;
        ttp = TTPToken(_ttptadd);
    }
    
    //Función para el registro de los alumnos
    //Puede ser llamada sólo por el address del profesor para registro de alumnos
    function registrarAlumno(
        uint _matricula, 
        string memory _nombreCompleto,
        string memory _campus,
        string memory _grupo,
        address _ttpTokenAddress
        ) public payable soloProfesor returns (bool ok){
        
        //Al registrar a un alumno con su matricula se le asignan 100 tokens
        mRegistros[_matricula] = Alumno(_matricula,_nombreCompleto,_campus,_grupo,_ttpTokenAddress);
        
        ttp.transferFrom(profesor, _ttpTokenAddress, 100);
        
        return true;
    }
    
    //Función modificaPuntos para sumar o restar puntos a los alumnos
    //Puede ser llamada sólo por quien haya registrado el smart contract 
    //Que debe ser el address registrado como profesor
    function modificaPuntos(
        //uint _matricula, 
        address _ttpTokenAddress,
        int _puntos,
        uint opcion,
        bytes32 _mensaje
        ) public soloProfesor returns (int saldo){
        
        //validar si es resta
        if(opcion == 0){
            uint tokens = uint(_puntos);
            assert(tokens > 0);

            ttp.transferFrom(_ttpTokenAddress, profesor, tokens);

        }
        else{
            //suma
            uint tokens = uint(_puntos);
            assert(tokens > 0);
            ttp.transferFrom(profesor, _ttpTokenAddress, tokens);
        }

        //Registra el mensaje
        bytes32[] storage txsls = mRegistrosT[_ttpTokenAddress];
        txsls.push(_mensaje);
        mRegistrosI[_ttpTokenAddress] = txsls.length;
        
        return _puntos;
    }
    
    function getPuntos(address _address) public view returns(uint256 puntos){
        return ttp.balanceOf(_address);
    }
    
    function modificaCurso(
        uint _curso) public soloProfesor returns (bool ok){
        
        curso = _curso;
        
        return true;
    }
       
    function getCurso() public view returns(uint thecurso){ 
        return curso;
    }  
    
    function getProfesor() public view returns(address theprofesor){
        return profesor;
    }

    function getTransactions(address _address) public view returns(bytes32[] memory mRegistrosLs){
        bytes32[] memory txsls = mRegistrosT[_address];
        
        return txsls;
    }
    
}