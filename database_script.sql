create table "Utilizador"
(
    id_utilizador serial
        primary key,
    nome          varchar(250)          not null,
    num_horas     integer,
    username      varchar(250)          not null
        unique,
    password      varchar(250)          not null,
    admin         boolean default false not null,
    super_user    boolean default false not null
);

alter table "Utilizador"
    owner to postgres;

create index idx_utilizador_username
    on "Utilizador" (username);

create table "Projeto"
(
    id_projeto    serial
        primary key,
    nome          varchar(250) not null,
    nome_cliente  varchar(250),
    descricao     text,
    preco_hora    numeric,
    id_utilizador integer
        references "Utilizador",
    data_criacao  date default CURRENT_DATE
);

alter table "Projeto"
    owner to postgres;

create index idx_projeto_utilizador
    on "Projeto" (id_utilizador);

create table "Tarefa"
(
    id_tarefa   serial
        primary key,
    descricao   text                      not null,
    data_inicio date default CURRENT_DATE not null,
    data_fim    date,
    estado      varchar(250)              not null,
    responsavel integer                   not null
        references "Utilizador"
);

alter table "Tarefa"
    owner to postgres;

create index idx_tarefa_responsavel
    on "Tarefa" (responsavel);

create table "Membro"
(
    id_membro        serial
        primary key,
    id_utilizador    integer      not null
        references "Utilizador",
    id_projeto       integer      not null
        references "Projeto",
    data_convite     date default CURRENT_DATE,
    data_estado      date,
    estado_convite   varchar(250) not null,
    estado_atividade varchar(250)
);

alter table "Membro"
    owner to postgres;

create index idx_membro_utilizador
    on "Membro" (id_utilizador);

create index idx_membro_projeto
    on "Membro" (id_projeto);

create table "Tarefa_Projeto"
(
    id_tarefa  integer not null
        references "Tarefa",
    id_projeto integer not null
        references "Projeto",
    primary key (id_tarefa, id_projeto)
);

alter table "Tarefa_Projeto"
    owner to postgres;

create index idx_tarefa_projeto_tarefa
    on "Tarefa_Projeto" (id_tarefa);

create index idx_tarefa_projeto_projeto
    on "Tarefa_Projeto" (id_projeto);

create table "Tarefa_Utilizador"
(
    id_utilizador integer not null
        references "Utilizador",
    id_tarefa     integer not null
        references "Tarefa",
    primary key (id_utilizador, id_tarefa)
);

alter table "Tarefa_Utilizador"
    owner to postgres;

create index idx_tarefa_utilizador_tarefa
    on "Tarefa_Utilizador" (id_tarefa);

create index idx_tarefa_utilizador_utilizador
    on "Tarefa_Utilizador" (id_utilizador);