CREATE TABLE rol (
    idrol INT IDENTITY(1,1) NOT NULL,
    rol VARCHAR(45) NULL,
    CONSTRAINT PK_rol PRIMARY KEY (idrol)
);

CREATE TABLE dbo.usuario (
    idusuario NVARCHAR(30) NOT NULL,
    nombre NVARCHAR(45) NOT NULL,
    apellido NVARCHAR(45) NULL,
    contraseña NVARCHAR(225) NOT NULL,
    biografia NVARCHAR(MAX) NULL,
    foto NVARCHAR(225) NULL,
    banner NVARCHAR(225) NULL,
    rol_idrol INT NOT NULL,
    CONSTRAINT PK_usuario PRIMARY KEY (idusuario),
    CONSTRAINT UQ_idusuario UNIQUE (idusuario),
    CONSTRAINT FK_usuario_rol FOREIGN KEY (rol_idrol)
        REFERENCES dbo.rol (idrol)
);

CREATE TABLE dbo.correo (
    idcorreo NVARCHAR(30) NOT NULL,
    correo NVARCHAR(120) NOT NULL,
    usuario_idusuario NVARCHAR(30) NOT NULL,
    CONSTRAINT PK_correo PRIMARY KEY (idcorreo),
    CONSTRAINT UQ_correo UNIQUE (correo),
    CONSTRAINT FK_correo_usuario FOREIGN KEY (usuario_idusuario)
        REFERENCES dbo.usuario (idusuario)
);

CREATE TABLE dbo.telefono (
    idtelefono NVARCHAR(30) NOT NULL,
    telefono NVARCHAR(45) NULL,
    usuario_idusuario NVARCHAR(30) NOT NULL,
    CONSTRAINT PK_telefono PRIMARY KEY (idtelefono),
    CONSTRAINT FK_telefono_usuario FOREIGN KEY (usuario_idusuario)
        REFERENCES dbo.usuario (idusuario)
);

CREATE TABLE dbo.lista (
    idlista INT IDENTITY(1,1) NOT NULL,
    clase NVARCHAR(30) NULL,
    CONSTRAINT PK_lista PRIMARY KEY (idlista),
    CONSTRAINT UQ_idlista UNIQUE (idlista)
);

CREATE TABLE dbo.tipo (
    idtipo INT IDENTITY(1,1) NOT NULL,
    nombretipo NVARCHAR(45) NULL,
    CONSTRAINT PK_tipo PRIMARY KEY (idtipo)
);

CREATE TABLE dbo.nivel (
    idnivel INT IDENTITY(1,1) NOT NULL,
    nombrenivel NVARCHAR(45) NULL,
    CONSTRAINT PK_nivel PRIMARY KEY (idnivel)
);

CREATE TABLE dbo.clase (
    idclase NVARCHAR(30) NOT NULL,
    titulo NVARCHAR(225) NOT NULL,
    descripcion NVARCHAR(MAX) NOT NULL,
    fecha_inicio DATE NULL,
    fecha_finalizacion DATE NULL,
    usuario_idusuario NVARCHAR(30) NOT NULL,
    lista_idlista INT NOT NULL,
    tipo_idtipo INT NOT NULL,
    nivel_idnivel INT NOT NULL,
    imagen NVARCHAR(225) NULL,
    CONSTRAINT PK_clase PRIMARY KEY (idclase),
    CONSTRAINT UQ_idclase UNIQUE (idclase),
    CONSTRAINT FK_clase_usuario FOREIGN KEY (usuario_idusuario)
        REFERENCES dbo.usuario (idusuario),
    CONSTRAINT FK_clase_lista FOREIGN KEY (lista_idlista)
        REFERENCES dbo.lista (idlista),
    CONSTRAINT FK_clase_tipo FOREIGN KEY (tipo_idtipo)
        REFERENCES dbo.tipo (idtipo),
    CONSTRAINT FK_clase_nivel FOREIGN KEY (nivel_idnivel)
        REFERENCES dbo.nivel (idnivel)
);

CREATE TABLE dbo.lista_has_usuario (
    lista_idlista INT NOT NULL,
    usuario_idusuario NVARCHAR(30) NOT NULL,
    PRIMARY KEY (lista_idlista, usuario_idusuario),
    CONSTRAINT FK_lista_has_usuario_lista FOREIGN KEY (lista_idlista)
        REFERENCES dbo.lista (idlista),
    CONSTRAINT FK_lista_has_usuario_usuario FOREIGN KEY (usuario_idusuario)
        REFERENCES dbo.usuario (idusuario)
);

CREATE TABLE dbo.comentario (
    idcomentario INT IDENTITY(1,1) NOT NULL,
    comentario NVARCHAR(MAX) NOT NULL,
    clase_idclase NVARCHAR(30) NOT NULL,
    usuario_idusuario NVARCHAR(30) NOT NULL,
    CONSTRAINT PK_comentario PRIMARY KEY (idcomentario),
    CONSTRAINT FK_comentario_clase FOREIGN KEY (clase_idclase)
        REFERENCES dbo.clase (idclase),
    CONSTRAINT FK_comentario_usuario FOREIGN KEY (usuario_idusuario)
        REFERENCES dbo.usuario (idusuario)
);

CREATE TABLE dbo.publicacion (
    idpublicacion INT IDENTITY(1,1) NOT NULL,
    texto NVARCHAR(MAX) NOT NULL,
    imagen NVARCHAR(225) NULL,
    clase_idclase NVARCHAR(30) NOT NULL,
    usuario_idusuario NVARCHAR(30) NOT NULL,
    CONSTRAINT PK_publicacion PRIMARY KEY (idpublicacion),
    CONSTRAINT FK_publicacion_clase FOREIGN KEY (clase_idclase)
        REFERENCES dbo.clase (idclase),
    CONSTRAINT FK_publicacion_usuario FOREIGN KEY (usuario_idusuario)
        REFERENCES dbo.usuario (idusuario)
);

CREATE TABLE dbo.quiz (
    idquiz NVARCHAR(30) NOT NULL,
    titulo NVARCHAR(100) NOT NULL,
    descripcion NVARCHAR(MAX) NULL,
    clase_idclase NVARCHAR(30) NOT NULL,
    usuario_idusuario NVARCHAR(30) NOT NULL,
    CONSTRAINT PK_quiz PRIMARY KEY (idquiz),
    CONSTRAINT FK_quiz_clase FOREIGN KEY (clase_idclase)
        REFERENCES dbo.clase (idclase),
    CONSTRAINT FK_quiz_usuario FOREIGN KEY (usuario_idusuario)
        REFERENCES dbo.usuario (idusuario)
);

CREATE TABLE dbo.pregunta (
    idpregunta NVARCHAR(30) NOT NULL,
    pregunta NVARCHAR(MAX) NOT NULL,
    quiz_idquiz NVARCHAR(30) NOT NULL,
    CONSTRAINT PK_pregunta PRIMARY KEY (idpregunta),
    CONSTRAINT FK_pregunta_quiz FOREIGN KEY (quiz_idquiz)
        REFERENCES dbo.quiz (idquiz)
);

CREATE TABLE dbo.opcion (
    idopcion INT IDENTITY(1,1) NOT NULL,
    opcion NVARCHAR(1) NOT NULL,
    respuesta NVARCHAR(100) NOT NULL,
    calificacion INT NOT NULL,
    pregunta_idpregunta NVARCHAR(30) NOT NULL,
    CONSTRAINT PK_opcion PRIMARY KEY (idopcion),
    CONSTRAINT FK_opcion_pregunta FOREIGN KEY (pregunta_idpregunta)
        REFERENCES dbo.pregunta (idpregunta)
);

CREATE TABLE dbo.respuesta (
    idrespuesta NVARCHAR(30) NOT NULL,
    opcion NVARCHAR(1) NOT NULL,
    respuesta NVARCHAR(100) NULL,
    calificacion INT NULL,
    quiz_idquiz NVARCHAR(30) NOT NULL,
    pregunta_idpregunta NVARCHAR(30) NOT NULL,
    usuario_idusuario NVARCHAR(30) NOT NULL,
    clase_idclase NVARCHAR(30) NOT NULL,
    CONSTRAINT PK_respuesta PRIMARY KEY (idrespuesta),
    CONSTRAINT FK_respuesta_quiz FOREIGN KEY (quiz_idquiz)
        REFERENCES dbo.quiz (idquiz),
    CONSTRAINT FK_respuesta_pregunta FOREIGN KEY (pregunta_idpregunta)
        REFERENCES dbo.pregunta (idpregunta),
    CONSTRAINT FK_respuesta_usuario FOREIGN KEY (usuario_idusuario)
        REFERENCES dbo.usuario (idusuario),
    CONSTRAINT FK_respuesta_clase FOREIGN KEY (clase_idclase)
        REFERENCES dbo.clase (idclase)
);

CREATE TABLE dbo.calificacion (
    idcalificacion NVARCHAR(30) NOT NULL,
    preguntas INT NOT NULL,
    respuestas INT NOT NULL,
    calificacion FLOAT NULL,
    quiz_idquiz NVARCHAR(30) NOT NULL,
    usuario_idusuario NVARCHAR(30) NOT NULL,
    clase_idclase NVARCHAR(30) NOT NULL,
    CONSTRAINT PK_calificacion PRIMARY KEY (idcalificacion),
    CONSTRAINT FK_calificacion_quiz FOREIGN KEY (quiz_idquiz)
        REFERENCES dbo.quiz (idquiz),
    CONSTRAINT FK_calificacion_usuario FOREIGN KEY (usuario_idusuario)
        REFERENCES dbo.usuario (idusuario),
    CONSTRAINT FK_calificacion_clase FOREIGN KEY (clase_idclase)
        REFERENCES dbo.clase (idclase)
);
