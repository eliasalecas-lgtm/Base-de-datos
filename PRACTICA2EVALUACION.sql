create database depVall;
use depVall;
create table CentroDeportivo(
    idCentro int primary key,
    direccion varchar(200),
    telefono char(9),
    capacidad int,
    localidad varchar(100)
);
create table Persona(
    dni char(9) primary key,
    nombre varchar(50),
    apellidos varchar(100),
    telefono char(9)
);
create table Empleado (
    dni char(9) primary key,
    tipoEmpleado varchar(100),
    fechaAlta date,
    tipoContrato varchar(50),
    fechaBaja date,
    salario double,
    foreign key Empleado(dni) references Persona(dni)
);
create table Usuario(
    dni char(9) primary key,
    tipoUsuario varchar(50),
    fechaRegistro date,
    fechaBaja date,
    foreign key Usuario(dni) references Persona(dni)
);
create table Pista (
    idPista int,
    idCentro int,
    tipoEspacio varchar(50),
    capUsuarios int,
    capEspectadores int,
    precioHora double,
    estadoActual varchar(50),
    fechaUltRevision date,
    fechaUltRenovacion date,
    primary key (idPista,idCentro),
    foreign key Pista(idCentro) references centrodeportivo(idCentro)
);
create table Reserva (
    idPista int,
    idCentro int,
    fecha date,
    hora time,
    nHoras int,
    precio double,
    servicioLimpieza boolean,
    precioFinal double,
    primary key (idPista,idCentro,fecha,hora),
    foreign key Reserva(idPista,idCentro) references Pista(idPista,idCentro)
);
create table UsuarioReserva (
    idUsuario char(9),
    idPista int,
    idCentro int,
    fecha date,
    hora time,
    tipoParticipacion varchar(20),
    primary key (idUsuario,idPista,idCentro,fecha,hora),
    foreign key UsuarioReserva(idUsuario) references Usuario(dni),
    foreign key UsuarioReserva(idPista,idCentro,fecha,hora)
        references Reserva(idPista,idCentro,fecha,hora)
);
create table Tarea (
    idTarea int,
    idPista int,
    idCentro int,
    tipoTarea varchar(30),
    fechaSolicitud date,
    fechaRealizacion date,
    comentarios varchar(200),
    primary key (idTarea,idPista,idCentro),
    foreign key Tarea(idPista,idCentro) references Pista(idPista,idCentro)
);
create table TareaEmpleado (
    idTarea int,
    idPista int,
    idCentro int,
    idEmpleado char(9),
    primary key (idTarea,idPista,idCentro,idEmpleado),
    foreign key TareaEmpleado(idTarea,idPista,idCentro)
        references Tarea(idTarea,idPista,idCentro),
    foreign key TareaEmpleado(idEmpleado) references Empleado(dni)
);