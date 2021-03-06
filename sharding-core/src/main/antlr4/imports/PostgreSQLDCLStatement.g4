grammar PostgreSQLDCLStatement;

import PostgreSQLKeyword, Keyword, Symbol, PostgreSQLBase, BaseRule, DataType;

grant
    : GRANT privType columnList? (COMMA_ privType columnList?)* privOnClause TO roleSpecifications (WITH GRANT OPTION)?
    ;
    
privType
    : ALL PRIVILEGES?
    | SELECT
    | INSERT
    | UPDATE
    | DELETE
    | TRUNCATE
    | REFERENCES
    | TRIGGER
    | CREATE
    | CONNECT
    | TEMPORARY
    | TEMP
    | EXECUTE
    | USAGE
    ;
    
privOnClause
    : ON (
        TABLE? tableNames
        | ALL TABLES IN SCHEMA schemaNames
        | SEQUENCE sequenceNames
        | ALL SEQUENCES IN SCHEMA schemaNames
        | DATABASE databaseNames
        | DOMAIN domainNames
        | FOREIGN DATA WRAPPER fdwNames
        | FOREIGN SERVER serverNames
        | (FUNCTION | PROCEDURE | ROUTINE) routineName (LP_ (argMode? argName? dataType (COMMA_ argMode? argName? dataType)*)? RP_)?
          (COMMA_ routineName (LP_ (argMode? argName? dataType (COMMA_ argMode? argName? dataType)*)? RP_)?)*
        | ALL (FUNCTIONS | PROCEDURES | ROUTINES) IN SCHEMA schemaNames
        | LANGUAGE langNames
        | LARGE OBJECT loids
        | SCHEMA schemaNames
        | TABLESPACE tablespaceNames
        | TYPE typeNames
    )
    ;
    
fdwName
    : ID
    ;
    
fdwNames
    : fdwName (COMMA_ fdwName)*
    ;
    
argMode
    : IN | OUT | INOUT | VARIADIC
    ;
    
argName
    : ID
    ;
    
langName
    : ID
    ;
    
langNames
    : langName (COMMA_ langName)*
    ;
    
loid
    : ID
    ;
    
loids
    : loid (COMMA_ loid)*
    ;
    
roleSpecification
    : GROUP? roleName | PUBLIC | CURRENT_USER | SESSION_USER
    ;
    
roleSpecifications
    : roleSpecification (COMMA_ roleSpecification)*
    ;
    
grantRole
    : GRANT roleNames TO roleNames (WITH ADMIN OPTION)?
    ;
    
revoke
    : REVOKE (GRANT OPTION FOR)? privType columnList? (COMMA_ privType columnList?)* privOnClause FROM roleSpecifications (CASCADE | RESTRICT)?
    ;
    
revokeRole
    : REVOKE (ADMIN OPTION FOR)? roleNames FROM roleNames (CASCADE | RESTRICT)?
    ;
    
createUser
    : CREATE USER userName (WITH? roleOptions)?
    ;
    
roleOption
    : SUPERUSER
    | NOSUPERUSER
    | CREATEDB
    | NOCREATEDB
    | CREATEROLE
    | NOCREATEROLE
    | INHERIT
    | NOINHERIT
    | LOGIN
    | NOLOGIN
    | REPLICATION
    | NOREPLICATION
    | BYPASSRLS
    | NOBYPASSRLS
    | CONNECTION LIMIT NUMBER_
    | ENCRYPTED? PASSWORD STRING_
    | VALID UNTIL STRING_
    | IN ROLE roleNames
    | IN GROUP roleNames
    | ROLE roleNames
    | ADMIN roleNames
    | USER roleNames
    | SYSID STRING_
    ;
    
roleOptions
    : roleOption (COMMA_ roleOption)*
    ;
    
alterUser
    : ALTER USER roleSpecification WITH roleOptions
    ;
    
renameUser
    : ALTER USER userName RENAME TO userName
    ;
    
alterUserSetConfig
    : alterUserConfigOp SET configName ((TO | EQ_) (STRING_ | ID | NUMBER_ | DEFAULT) | FROM CURRENT)
    ;
    
configName
    : ID
    ;
    
alterUserConfigOp
    : ALTER USER (roleSpecification | ALL) (IN DATABASE databaseName)?
    ;
    
alterUserResetConfig
    : alterUserConfigOp RESET (configName | ALL)
    ;
    
dropUser
    : DROP USER (IF EXISTS)? roleNames
    ;
    
createRole
    : CREATE ROLE roleName (WITH? roleOptions)?
    ;
    
alterRole
    : ALTER ROLE roleSpecification WITH roleOptions
    ;
    
renameRole
    : ALTER ROLE roleName RENAME TO roleName
    ;
    
alterRoleSetConfig
    : alterRoleConfigOp SET configName ((TO | EQ_) (STRING_ | ID | NUMBER_ | DEFAULT) | FROM CURRENT)
    ;
    
alterRoleConfigOp
    : ALTER ROLE (roleSpecification | ALL) (IN DATABASE databaseName)?
    ;
    
alterRoleResetConfig
    : alterRoleConfigOp RESET (configName | ALL)
    ;
    
dropRole
    : DROP ROLE (IF EXISTS)? roleNames
    ;
